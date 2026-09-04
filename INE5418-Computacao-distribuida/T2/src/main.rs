mod colab_text_editor;

use colab_text_editor::node::Node;
use colab_text_editor::p2p_mesh::P2PMesh;


use std::sync::atomic::{AtomicUsize, Ordering};
// use std::collections::LinkedList;
// use std::net::SocketAddr;
// use std::io::{Error, Read, Write};
// use std::sync::Mutex;
// use socket2::{Socket, Domain, Type, Protocol};
use std::thread::{self};
use std::sync::Arc;
use std::error::Error;
use std::time::Duration;

pub fn run_tests(node: Arc<Node>) -> Result<(), Box<dyn Error>> {
    run_dummy(&node)?;
    println!("All tests completed. for node");
    Ok(())
}

fn run_dummy(node: &Arc<Node>) -> Result<(), Box<dyn Error>> {
    println!("Node {} starting operations.", node.id);
    let char_id: char = format!("{}", node.id).chars().next().expect("Failed to get char from node id");
    
    node.insert(char_id, 0)?;
    node.insert(char_id, 1)?;
    // node.delete(0)?;
    // sleep to allow message propagation
    // thread::sleep(std::time::Duration::from_millis(2000));
    Ok(())
}

static ADDR_COUNTER: AtomicUsize = AtomicUsize::new(0);
static GLOBAL_COUNTER: AtomicUsize = AtomicUsize::new(0);

/// [ ] - Concorrência de Inserção: Nó ID1 insere 'X' e Nó ID2 insere 'Y' na mesma posição (ex: no início).
///     - O CRDT deve garantir que 'X' e 'Y' apareçam na mesma ordem em ambos os nós
///     - (e.g., 'X Y' ou 'Y X', mas não 'X Y' em ID1 e 'Y X' em ID2).
fn conc_insertion_test() -> Result<(), Box<dyn Error>> {
    let qtd = 5;

    let mut addrs:Vec<String> = Vec::new();
        for _ in 0..qtd {
            addrs.push(format!("127.0.0.1:{}", 3000 + ADDR_COUNTER.fetch_add(1, Ordering::Relaxed)));
    }
    let mesh = P2PMesh::new(addrs.clone(), qtd);

    let mut nodes = vec![];
    let mut node_handles = vec![];
    for i in 0..qtd {
        println!("Creating agent {} on address {}", i, addrs[i as usize].clone());
        let node = Node::new(
            GLOBAL_COUNTER.fetch_add(1, Ordering::Relaxed) as u32, 
            addrs[i as usize].clone(), 
            mesh.clone());
        nodes.push(node);
    }
    for node in nodes {
        let char_to_insert;
        if node.id >= 10 {
            char_to_insert = ('a' as u8 + (node.id - 10) as u8) as char;
        } else {
            char_to_insert = char::from_digit(node.id, 10).unwrap();
        }
        
        let handle = thread::spawn(move || {
            thread::sleep(Duration::from_millis(1000));
            println!("Node {} running concurrent insertion test.", node.id);
            println!("node ID: {}", node.id);
            for i in 0..qtd*2 {
                node.insert(char_to_insert, i as usize).expect("Insertion failed");
            }
        });
        node_handles.push(handle);
    }
    let mut i = 0;
    for handle in node_handles {
        handle.join().expect(&format!("Failed to join node {} thread", i));
        i += 1;
    }

    // Implementar teste de concorrência de inserção
    // let counter = 3;
    // let mut handles = vec![];
    // for node in nodes {
    //     let handle = thread::spawn({
    //         let node = Arc::clone(node);
    //         move || {
    //             thread::sleep(Duration::from_millis(1000));
    //             println!("Node {} running concurrent insertion test.", node.id);
    //             let char_id: char = format!("{}", node.id).chars().next().expect("Failed to get char from node id");    
    //             for i in 0..counter {
    //                 node.insert(char_id, i).expect("Insertion failed");
    //             }
    //         }
    //     });
    //     handles.push(handle);
    // }
    // for handle in handles {
    //     handle.join().expect("Thread panicked");
    // }
    Ok(())
}
/// [ ] - Concorrência Inserção/Remoção: Nó ID1 insere um caractere 'Z'.
///     - Concorrentemente, Nó ID2 deleta o caractere anterior a 'Z'.
///     - Demonstração de que a operação é resolvida de forma consistente
///     - (o 'Z' inserido deve permanecer ou ser deletado em todos os nós).
fn conc_insertion_deletion_test() -> Result<(), Box<dyn Error>> {
    let qtd = 8;

    let mut addrs:Vec<String> = Vec::new();
        for _ in 0..qtd {
            addrs.push(format!("127.0.0.1:{}", 3000 + ADDR_COUNTER.fetch_add(1, Ordering::Relaxed)));
    }
    let mesh = P2PMesh::new(addrs.clone(), qtd);

    let mut nodes = vec![];
    let mut node_handles = vec![];
    for i in 0..qtd {
        println!("Creating agent {} on address {}", i, addrs[i as usize].clone());
        let node = Node::new(
            GLOBAL_COUNTER.fetch_add(1, Ordering::Relaxed) as u32, 
            addrs[i as usize].clone(), 
            mesh.clone());
        nodes.push(node);
    }
    for node in nodes {
        let char_to_insert;
        if node.id >= 10 {
            char_to_insert = ('a' as u8 + (node.id - 10) as u8) as char;
        } else {
            char_to_insert = char::from_digit(node.id, 10).unwrap();
        }

        let handle = thread::spawn(move || {
            println!("Node {} running concurrent insertion/deletion test.", node.id);
            node.insert(char_to_insert, 0).expect("Insertion failed");
            thread::sleep(Duration::from_millis(1000));
            if (node.id % 2) == 0 {
                // even nodes delete
                node.delete(0).expect("Deletion failed");
            } else {
                // odd nodes insert
                node.insert(char_to_insert, 3).expect("Insertion failed");
            }
        });
        node_handles.push(handle);
    }
    let mut i = 0;
    for handle in node_handles {
        handle.join().expect(&format!("Failed to join node {} thread", i));
        i += 1;
    }
    // Implementar teste de concorrência de inserção/remoção
    // let counter = nodes.len();
    // let mut handles = vec![];
    // for node in nodes {
    //     let handle = thread::spawn({
    //         let node = Arc::clone(node);
    //         move || {
    //             println!("Node {} running concurrent insertion/deletion test.", node.id);
    //             let char_id: char = format!("{}", node.id).chars().next().expect("Failed to get char from node id");
    //             node.insert(char_id, 0).expect("Insertion failed");
    //             thread::sleep(Duration::from_millis(1000));
    //             if (node.id % 2) == 0 {
    //                 // even nodes insert
    //                 node.insert(char_id, 1).expect("Insertion failed");
    //             } else {
    //                 // odd nodes delete
    //                 if counter > 0 {
    //                     node.delete(0).expect("Deletion failed");
    //                 }
    //             }
    //         }
    //     });
    //     handles.push(handle);
    // }
    // for handle in handles {
    //     handle.join().expect("Thread panicked");
    // }
    Ok(())
}


/// [-] - Mínimo 3 nós para a demonstração de que o sistema converge para o mesmo estado e ordem de caracteres em todos os nós.
fn main() {
    let qtd = 4;

    let mut addrs:Vec<String> = Vec::new();
        for _ in 0..qtd {
            addrs.push(format!("127.0.0.1:{}", 3000 + ADDR_COUNTER.fetch_add(1, Ordering::Relaxed)));
    }
    let mesh = P2PMesh::new(addrs.clone(), qtd);

    let mut nodes = vec![];
    let mut node_handles = vec![];
    for i in 0..qtd {
        println!("Creating agent {} on address {}", i, addrs[i as usize].clone());
        let node = Node::new(
            GLOBAL_COUNTER.fetch_add(1, Ordering::Relaxed) as u32, 
            addrs[i as usize].clone(), 
            mesh.clone());
        nodes.push(node);
    }
    
    for node in nodes {
        let handle = thread::spawn(move || {
            run_tests(node).expect("Tests failed");
        });
        node_handles.push(handle);
    }
    let mut i = 0;
    for handle in node_handles {
        handle.join().expect(&format!("Failed to join node {} thread", i));
        i += 1;
    }


    let _ = conc_insertion_test();
    let _ = conc_insertion_deletion_test();
}
