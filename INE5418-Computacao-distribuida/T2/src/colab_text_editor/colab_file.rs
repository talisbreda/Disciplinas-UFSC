use std::fs::File;
use std::io::{Write, Seek};

use super::colab_char::ColabChar;

pub struct ColabFile {
    // fields
    pub chars: Vec<ColabChar>,
    pub _size: usize,
    txt_file: File,
}

impl ColabFile {
    pub fn new(id: u32) -> Self {
        let file = File::create(format!("files/colab_file_{}.txt", id)).expect("Unable to create file");
        Self {
            chars: Vec::new(),
            _size: 0,
            txt_file: file,
        }
    }

    /// ● insert(caractere, posição):
    /// Nodes criam colabChars, o file só insere o ColabChar. a posição já ta ajustada.
    pub fn insert(&mut self, _char: ColabChar, _pos: usize) {
        // [0, 1, 2, 3, 4]. Insere(A, 3)
        // [0, 1, 2, 3, A, 4]
        self.chars.insert(_pos, _char);
        self._size += 1;
        self.reload_file();
    }


    /// marca como deleted=true o caractere na posição.
    pub fn delete(&mut self, _pos: usize) {
        self.chars[_pos].deleted = true;
        self.reload_file();
    }


    // /// marca como deleted=true o caractere na posição.
    // pub fn update(&mut self, _char: ColabChar, _pos: usize) {
    //     let char_antigo = self.chars[_pos].clone();
    //     self.chars[_pos] = _char;
    //     self.chars[_pos].deleted = char_antigo.deleted;
    //     self.reload_file();
    // }

    fn reload_file(&mut self) {
        // apaga o conteudo do arquivo
        self.txt_file.set_len(0).expect("Failed to clear file");
        self.txt_file.seek(std::io::SeekFrom::Start(0)).expect("Failed to seek to start of file");
        for c in &self.chars {
            if !c.deleted {
                self.txt_file.write(&[c.value as u8]).expect("Failed to write to file");
                self.txt_file.flush().expect("Failed to flush file");
            }
        }
    }
}