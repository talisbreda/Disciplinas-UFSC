// [-] - Relógios Vetoriais (Vector Clocks)
#[derive(PartialEq, Debug, Eq, PartialOrd, Ord)]
/// Mecanismo de rastreamento causal para garantir que as operações sejam aplicadas na ordem causal correta, 
pub struct VecClock {
    pub clock: Vec<i32>,
    pub precision: u32,
}

impl VecClock {
    // Implementação do relógio vetorial
    pub fn new() -> Self {
        Self {
            clock: Vec::new(),
            precision: 0,
        }
    }
}

// imply Copy and Clone for VecClock
impl Default for VecClock {
    fn default() -> Self {
        Self::new()
    }
}

impl std::clone::Clone for VecClock {
    fn clone(&self) -> Self {
        Self {
            clock: self.clock.clone(),
            precision: self.precision,
        }
    }
}