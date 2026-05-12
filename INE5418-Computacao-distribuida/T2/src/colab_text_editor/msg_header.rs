// Sugestão para os campos da Mensagem:

//     {
//         "type": "insert"|"delete",
//         "op_id": <VectorClock>,
//         "site_id": <ID_do_No>,
//         "pos_id": <ID_do_Caractere_Anterior_ou_Alvo>,
//         "char": <Caractere>
//     }

use super::vec_clock::VecClock;
use super::colab_char::ColabChar;

#[derive(Clone, Debug)]
pub struct Message {
    /// False = Insert. True = Delete
    pub deletion: bool,
    pub pos: u32,
    pub char: ColabChar,
}

impl Message {
    pub fn serialize(response: &Message) -> Vec<u8> {
        let mut buffer: Vec<u8> = vec![];
        buffer.push(response.deletion as u8);
        buffer.extend(response.pos.to_be_bytes());
        buffer.push(response.char.value as u8);
        buffer.extend(response.char.site_id.to_be_bytes());
        buffer.extend_from_slice(&response.char.op_stamp.to_be_bytes());
        buffer.extend(response.char.clock.precision.to_be_bytes());
        for &i in &response.char.clock.clock {
            buffer.extend_from_slice(&i.to_be_bytes());
        }
        buffer
    }

    pub fn deserialize(buffer: &Vec<u8>) -> Message {
        // Expected layout (Big-endian for everything):
        // [0]                 -> operation (1 byte)
        // [1..5)              -> position (4 Bytes)
        // [5..]              -> character (N bytes)
        let mut i = 0;
        let deleted = buffer[i] != 0;
        i += 1;
        let pos = u32::from_be_bytes(buffer[i..i+4].try_into().expect("Failed to parse buffer position"));
        i += 4;
        let value = buffer[i] as char;
        i += 1;
        let site_id = u32::from_be_bytes(buffer[i..i+4].try_into().expect("Failed to parse buffer position"));
        i += 4;
        let op_stamp = u32::from_be_bytes(buffer[i..i+4].try_into().expect("Failed to parse buffer position"));
        i += 4;
        let precision = u32::from_be_bytes(buffer[i..i+4].try_into().expect("Failed to parse buffer position"));
        i += 4;
        let mut clock: Vec<i32> = Vec::new();        
        while i < buffer.len() {
            clock.push(i32::from_be_bytes(buffer[i..i+4].try_into().expect("Failed to parse buffer position")));
            i += 4;
        }
        let clockvec = VecClock {clock: clock, precision};
        let character = ColabChar {value, deleted, clock: clockvec, site_id, op_stamp };
        Message {
            deletion: deleted,
            pos,
            char: character,
        }
    }
}

impl std::fmt::Display for Message {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let op = if self.deletion { "Delete" } else { "Insert" };
        write!(f, "Message {{ operation: {}, pos: {}, char: {:?} }}",op, self.pos, self.char)
    }
}