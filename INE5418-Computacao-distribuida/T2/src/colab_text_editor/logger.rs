use std::fs::File;
use std::io::{Write, Seek};
use std::sync::{Arc, Mutex};

pub struct Logger {
    // Implementação do logger
    file: Arc<Mutex<File>>,
}

impl Logger {
    pub fn new(file_path: String) -> Self {
        let path = "logs/" .to_string() + &file_path;
        let mut file = File::create(path).expect("Failed to create log file");
        file.set_len(0).expect("Failed to clear file");
        file.seek(std::io::SeekFrom::Start(0)).expect("Failed to seek to start of file");
        let file = Arc::new(Mutex::new(file));
        Self { file }
    }
    
    pub fn printf(&self, msg: &str) {
        if let Ok(mut file) = self.file.lock() {
            let msg = format!("{}\n", msg);
            file.write(msg.as_bytes()).expect("Failed to write to log file");
            file.flush().expect("Failed to flush log file");        
        }
    }
}