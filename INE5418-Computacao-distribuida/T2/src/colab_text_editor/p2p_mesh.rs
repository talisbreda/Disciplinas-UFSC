// [-] - Utilizar programação com **sockets TCP/IP**
//     para confiabilidade na entrega das operações de comunicação.
// [-] - Cada nó deve manter conexões TCP ativas com todos os outros nós conhecidos (full-mesh P2P);


use socket2::SockAddr;
use std::net::SocketAddr;

#[derive(Clone)]
/// Implementação da malha P2P
pub struct P2PMesh {
    pub addrs: Vec<SockAddr>,
    _size: u32
}

impl P2PMesh {
    pub fn new(addrs: Vec<String>, _size: u32) -> Self {
        let addrs: Vec<SockAddr> = addrs.iter().map(|addr_str| {
            let socket_addr: SocketAddr = addr_str.parse().expect("Invalid address");
            SockAddr::from(socket_addr)
        }).collect();
        Self {
            addrs,
            _size,
        }
    }
}