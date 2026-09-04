// [-] -  implementar um editor de texto colaborativo.
//     [-] - um grupo de nós deve poder modificar o mesmo documento de texto concorrentemente,
//     [-] - incluindo inserções e remoções em qualquer posição
// [-] - cada nó recebe um ID único de localização (site ID).
// [-] - Cada nó representa uma instância do editor.
// [-] - Os nós da rede participam de um grupo que mantém o texto replicado.
// [ ] - o programa deve permitir visualizar a tela de cada nó.
// [ ] - Deve ser possível observar o texto do documento incluindo os caracteres não removidos.
// [ ] - Apresentar também um registro (log) de operações recebidas.

// mutex
use std::sync::{Arc, Mutex};
// threads
use std::thread;
// sockets
use std::net::{SocketAddr, TcpStream, TcpListener};
use std::io::{Read, Write, Error, ErrorKind};
// for Socket
use socket2::{Socket, Domain, Type, Protocol};

use super::p2p_mesh::P2PMesh;
use super::colab_file::ColabFile;
use super::logger::Logger;
use super::msg_header::Message;
use super::colab_char::ColabChar;
use super::vec_clock::VecClock;

pub struct Node {
    // Implementação do nó do editor de texto colaborativo
    pub id: u32,
    ins_count: Arc<Mutex<u32>>,
    addr: SocketAddr,
    mesh: Arc<Mutex<P2PMesh>>,
    file: Arc<Mutex<ColabFile>>,
    logger: Logger,
}

impl Node {
    pub fn new(id: u32, addr: String, mesh: P2PMesh) -> Arc<Self> {
        let addr: SocketAddr = addr.parse().expect("Invalid address");
        let mesh = Arc::new(Mutex::new(mesh));
        let file = Arc::new(Mutex::new(ColabFile::new(id)));
        let log_path = format!("node_{}_log.txt", id);
        let logger = Logger::new(log_path);
        let ins_count = Arc::new(Mutex::new(0u32));
        let node_arc: Arc<Node> = Arc::new(Node { id, addr, mesh, file, logger, ins_count });
        let node_clone: Arc<Node> = Arc::clone(&node_arc);
        thread::spawn({
            move || {
                node_clone.listener();
            }
        });
        node_arc.logger.printf(&format!("Node {} initialized at address {}", id, addr));
        node_arc        
    }

    pub fn send(&self, msg: Message) -> Result<(), Error> {
        let buffer = Message::serialize(&msg);
        self.logger.printf(&format!("Node {} sending message: op={}, pos={}, char='{}'", self.id, msg.deletion, msg.pos, msg.char.value));
        if let Ok(mesh) = self.mesh.lock() {
            for addr in &mesh.addrs {
                let skt = Socket::new(Domain::IPV4, Type::STREAM, Some(Protocol::TCP))?;
                skt.set_reuse_address(true)?;
                skt.connect(addr.into())?;
                let mut stream: TcpStream = skt.into();
                stream.write_all(&buffer)?;
                stream.flush()?;
                self.logger.printf(&format!("Node {} sent message to peer", self.id));
            }
            Ok(())
        } else {
            Err(Error::new(ErrorKind::Other, "Failed to lock mesh for sending"))
        }
    }


    pub fn loop_back(&self, msg: Message) -> Result<(), Error> {
        let buffer = Message::serialize(&msg);
        self.logger.printf(&format!("Node {} sending message: op={}, pos={}, char='{}'", self.id, msg.deletion, msg.pos, msg.char.value));
        let skt = Socket::new(Domain::IPV4, Type::STREAM, Some(Protocol::TCP))?;
        skt.set_reuse_address(true)?;
        skt.connect(&self.addr.into())?;
        let mut stream: TcpStream = skt.into();
        stream.write_all(&buffer)?;
        stream.flush()?;
        self.logger.printf(&format!("Node {} sent message to peer", self.id));
        Ok(())
    }


    fn get_new_clock(&self, pos: usize, file: &mut Vec<ColabChar>) -> VecClock {
        let size = file.len();
        let pos = if size == 0 {
            0
        } else {
            if pos > size - 1 {size - 1} else {pos}
        };
        if pos + 1 < size {
            let current_char = file[pos].clone();
            let next_char = &mut file[pos+1];
            let mut new_clock = current_char.clock;

            // Cases: (_) indicates where you're inserting new char
            // (3.2) (_) (4) -> 3.3
            // (3) (_) (3.0) -> 3.-1
            // (3.2) (_) (3.3) -> 3.2.1
            // (3.2.1 / id2) (_) (3.2.1 / id3) -> (3.2.1.1 / id2)
            if new_clock.precision > next_char.clock.precision {
                new_clock.clock[(new_clock.precision-1) as usize] += 1;
            } else if new_clock.precision < next_char.clock.precision {
                new_clock = next_char.clock.clone();
                new_clock.clock[(new_clock.precision-1) as usize] -= 1;
            } else {
                new_clock.clock.push(1);
                new_clock.precision += 1;
            }
            self.logger.printf(&format!("Node {} inserting at pos {}, current pos clock: {:?}, new clock: {:?}",
                    self.id,
                    pos,
                    next_char.clock,
                    new_clock.clock
                ));
            new_clock
        } else {
            let (position, precision) = if size == 0 {
                (vec![0; 1], 1)
            } else {
                let last_char = &mut file[size-1];
                (last_char.clock.clock.clone(), last_char.clock.precision)
            };
            self.logger.printf(&format!("Node {} inserting at end, last pos clock: {:?} with precision {}", self.id, position, precision));
            VecClock {clock: position, precision: precision}
        }
    }

    /// ● insert(caractere, posição):
    /// [-] - Gera um novo Position ID para o caractere,
    ///     garantindo que ele caia na ordem correta.
    /// [-] - Então, aplica a inserção localmente;
    ///     cria uma mensagem de Operação com o novo Position ID e o caractere;
    ///     e envia a mensagem para todos os nós da rede.
    /// [-] - Se a inserção ocorrer entre caracteres A e B, o novo caractere recebe um ID logicamente maior que A e menor que B.
    /// - Se houver concorrência no mesmo ponto, o site_id atua como desempate final.
    pub fn insert(&self, _char: char, _pos: usize) -> Result<(), Error> {
        if let Ok(mut file) = self.file.lock() {
            let size = file.chars.len();
            let pos = if _pos > size { size } else { _pos };
            self.logger.printf(&format!("Node {} inserting character '{}' at pos {}", self.id, _char, pos));
            let new_clock = self.get_new_clock(pos, &mut file.chars);
            if let Ok(mut ic) = self.ins_count.lock() {
                *ic += 1;               
                let new_char = ColabChar::new(_char, new_clock, self.id, *ic);
                let msg = Message {deletion: false, pos: pos as u32, char: new_char};
                self.send(msg)?;
                Ok(())
            } else {
                Err(Error::new(ErrorKind::Other, "Insert Failed to lock insertion counter"))
            }
        } else {
            Err(Error::new(ErrorKind::Other, "Insert Failed to lock file for insertion"))
        }
    }

    /// ● delete(posição):
    /// [-] - Localiza o caractere a ser removido;
    /// [-] - altera o seu estado para deleted=true;
    /// [-] - cria uma mensagem de Operação de remoção que referencia o Position ID do caractere alvo;
    /// [-] - envia a mensagem para todos os nós da rede.
    pub fn delete(&self, pos: usize) -> Result<(), Error> {
        if let Ok(file) = self.file.lock() {
            self.logger.printf(&format!("Node {} deleting character at pos {}", self.id, pos));
            let del_char = if pos >= file.chars.len() {
                if file.chars.len() == 0 {
                    ColabChar::new('\0', VecClock {clock: vec![0], precision: 1}, self.id, 0)
                } else {
                    file.chars[file.chars.len() - 1].clone()
                } 
            } else {
                file.chars[pos].clone()
            };
            let msg = Message {deletion: true, pos: pos as u32, char: del_char};
            self.logger.printf(&format!("Node {} created delete message for pos {}", self.id, pos));
            self.send(msg)?;
            Ok(())
         } else {
            Err(Error::new(ErrorKind::Other, "Delete Failed to lock file for deletion"))
         }
    }

    /// ● merge(mensagem_op):
    /// [-] - O nó local recebe uma operação de outro nó (via socket),
    /// [-] - Então aplica a mudança:
    ///     [-] - Inserção Remota:
    ///         Insere o novo caractere na posição correta na lista, baseando-se em seu Position ID (que garantirá a ordem);
    ///     [-] - Remoção Remota: Localiza o caractere pelo Position ID e o marca como deleted=true.
    /// [-] - Evitar a duplicação de operações.
    /// [ ] - A idempotência e comutatividade do merge (princípio do CRDT) devem ser garantidas ao aplicar a lógica.
    fn merge(&self, msg: Message) -> Result<(), Error> {
        if let Ok(mut file) = self.file.lock() {
            let mut c_vec: String = String::new();
            for i in &file.chars {
                let clock = i.clock.clone();
                for c in &clock.clock {
                    c_vec.push_str(&format!("{}.", c));
                }
                c_vec.push_str(&format!(" | "));
            }
            self.logger.printf(&format!(">> Node {} merging message:\nop={}, pos={}, char='{}' | Current file clocks:\n - {}",
                self.id,
                msg.deletion,
                msg.pos,
                msg.char.value,
                c_vec
            ));
            if msg.deletion {
                // Find the character with the EXACT same clock and site_id to delete
                if let Some(index) = file.chars.iter().position(|c| 
                    c.clock == msg.char.clock && c.site_id == msg.char.site_id
                ) {
                    file.delete(index);
                    self.logger.printf(&format!("Node {} merged delete at discovered index {}", self.id, index));
                } else {
                    // If we assume causal delivery, the char should be here. 
                    // If not, in a robust system, we might buffer this 'tombstone', 
                    // but strictly do NOT loop_back based on index.
                    self.logger.printf(&format!("Node {} could not find char to delete (idempotency check)", self.id));
                }
                // if pos >= size {
                //     self.logger.printf(&format!("Node {} merge: position {} out of bounds (size {})", self.id, pos, size));
                //     return self.loop_back(msg);
                // }
                // let mut char_temp = &mut file.chars[pos as usize];
                // while char_temp.clock != msg.char.clock || char_temp.site_id != msg.char.site_id {
                //     if *char_temp < msg.char {
                //         pos += 1;
                //         if pos >= size {
                //             self.logger.printf(&format!("Node {} merge delete: character not found, reached end of file", self.id));
                //             return self.loop_back(msg);
                //         }
                //     } else if pos > 0 {
                //         pos -= 1;
                //     } else {
                //         self.logger.printf(&format!("Node {} merge delete: character not found, reached start of file", self.id));
                //         return self.loop_back(msg);
                //     }
                //     char_temp = &mut file.chars[pos as usize];
                // }
                // file.delete(pos as usize);
            } else {
                // INSERTION
                // We need to find the index `i` such that:
                // chars[i-1] < msg.char < chars[i]
                
                // 1. Check if it already exists (Idempotency)
                let exists = file.chars.iter().any(|c| 
                    c.clock == msg.char.clock && c.site_id == msg.char.site_id
                );
            
                if exists {
                    self.logger.printf(&format!("Node {} received duplicate insert, ignoring.", self.id));
                    return Ok(());
                }

                // 2. Find insertion index based on Sort Order
                let mut insert_index = file.chars.len(); // Default to end
                for (i, c) in file.chars.iter().enumerate() {
                    // Assuming ColabChar implements Ord/PartialOrd correctly:
                    if msg.char < *c {
                        insert_index = i;
                        break;
                    }
                }

                // 3. Apply Local Insert
                // Note: We call a raw insert on the vector, bypassing logic 
                // that generates new clocks, because this clock is already fixed.
                file.insert( msg.char, insert_index);
                self.logger.printf(&format!("Node {} merged insert at calculated index {}", self.id, insert_index));
                // if pos > size {
                //     self.logger.printf(&format!("Node {} merge: position {} out of bounds (size {})", self.id, pos, size));
                //     return self.loop_back(msg);
                // } else if pos == size {
                //     file.insert(msg.char, pos as usize);
                //     return Ok(());
                // }
                // let mut char_temp = &file.chars[pos as usize];
                // // 3.(3.2.1) 4.(3.4.2) 5.(3.4.3) 6.(3.4.4) Insert(3, 3.4.5) // caso insert defasado pra trás
                // // char_temp = (3.2.1) < insert
                // // 3.(3.2.1) 4.(3.4.2) 5.(3.4.3) 6.(3.4.4) Insert(6, 3.2.2) // caso insert defasado pra frente
                // // char_temp = (3.4.4) < insert
                // // 5.(3.0.2) 6.(3.1) // insert(5, 3.0.3) // Caso insert posição correta
                // // char_temp = (3.0.2) < insert
    
                // // Worst-case scenario
                // // 3.(3.2.1) 4.(3.4.2 / 2) 5.(3.4.3)   insert(4, 3.4.2 / 3)
                // // char_temp = (3.4.2 / 2) < insert
                
                // while *char_temp < msg.char && pos < size - 1 {
                //     pos += 1;
                //     char_temp = &mut file.chars[pos as usize];
                // }
                // while *char_temp > msg.char && pos > 0 {
                //     pos -= 1;
                //     char_temp = &mut file.chars[pos as usize];
                // }

                // if (*char_temp).clock == msg.char.clock {
                //     let mut new_char = if *char_temp < msg.char {
                //         msg.char.clone()
                //     } else {
                //         let out = (*char_temp).clone();
                //         file.update(msg.char, pos as usize);
                //         out
                //     };
                //     new_char.clock.clock.push(1);
                //     new_char.clock.precision += 1;
                //     // print!("\n> {:?} -> ", new_char.clock.clock);
                //     let msg = Message {deletion: false, pos: pos as u32, char: new_char};
                //     self.loop_back(msg)?;
                // } else {
                //     file.insert(msg.char, pos as usize);
                // }
            }
            Ok(())
        } else {
            Err(Error::new(ErrorKind::Other, "Merge Failed to lock file for merging"))
        }
    }


    // listener thread to receive messages via socket
    fn listener(self: Arc<Self>) {
        let socket = TcpListener::bind(self.addr).expect("Failed to bind server address");
        loop {
            let (mut stream, _) = match socket.accept() {
                Ok((s, addr)) => {
                    (s, addr)
                },
                Err(e) => {
                    dbg!("Failed to accept connection: {}", e);
                    continue;
                }
            };
            let mut buffer = vec![0; 1024];
            let amt = stream.read(&mut buffer).expect("Failed to read from socket");
            buffer.truncate(amt);
            let msg = Message::deserialize(&buffer);
            match self.merge(msg.clone()) {
                Ok(_) => {
                    self.logger.printf(&format!("Node {} successfully merged received message {}", self.id, msg));
                },
                Err(e) => {
                    self.logger.printf(&format!("Node {} failed to merge received message: {}", self.id, e));
                    match self.send(msg) {
                        Ok(_) => {
                            self.logger.printf(&format!("Node {} resent message after merge failure", self.id));
                        },
                        Err(e) => {
                            self.logger.printf(&format!("Node {} failed to resend message after merge failure: {}", self.id, e));
                        }
                    }
                }
            }
        }
    }
}