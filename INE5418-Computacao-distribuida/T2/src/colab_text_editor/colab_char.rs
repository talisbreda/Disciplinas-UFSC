
use super::vec_clock::VecClock;

#[derive(Clone, PartialEq, Debug, Eq)]
pub struct ColabChar {
    ///     ● valor: O caractere em si (p.ex., 'A', 'b', ' ');
    pub value: char,
    ///     ● deleted: Um valor booleano para marcar remoções.
    pub deleted: bool,
    ///     ● id: O Position ID único;
    /// Por simplicidade, adote Position ID = (VectorClock_insercao_local, site_id).
    pub clock: VecClock, // VectorClock_insercao_local,
    pub site_id: u32, // site_id
    /// A counter of written digits
    pub op_stamp: u32,
}

impl ColabChar {
    pub fn new(value: char, clock: VecClock, site_id: u32, op_stamp: u32) -> Self {
        Self {
            value,
            deleted: false,
            clock,
            site_id,
            op_stamp,
        }
    }
}

// Implement ordering based on p_id only
impl std::cmp::PartialOrd for ColabChar {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}
// char_temp.p_id.0 < _char.p_id.0 || (char_temp.p_id.0 == _char.p_id.0 && char_temp.p_id.1 < _char.p_id.1
impl std::cmp::Ord for ColabChar {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        if self.clock < other.clock {
            std::cmp::Ordering::Less
        } else if self.clock > other.clock {
            std::cmp::Ordering::Greater
        } else {
            if self.site_id < other.site_id {
                std::cmp::Ordering::Less
            } else if self.site_id > other.site_id {
                std::cmp::Ordering::Greater
            } else {
                self.op_stamp.cmp(&other.op_stamp)                
            }
        }
    }
}