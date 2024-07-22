#[derive(Drop)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
    Debug,
}

pub fn log(level: LogLevel, message: ByteArray) -> ByteArray {
    match level {
        LogLevel::Info => info(message),
        LogLevel::Warning => warn(message),
        LogLevel::Error => error(message),
        LogLevel::Debug => format!("[DEBUG]: {message}"),
    }
}

pub fn info(message: ByteArray) -> ByteArray {
    format!("[INFO]: {message}")
}

pub fn warn(message: ByteArray) -> ByteArray {
    format!("[WARNING]: {message}")
}

pub fn error(message: ByteArray) -> ByteArray {
    format!("[ERROR]: {message}")
}
