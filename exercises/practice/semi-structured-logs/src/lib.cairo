/// various log levels
#[derive(Drop)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
    Debug
}

/// primary function for emitting logs
pub fn log(level: LogLevel, message: ByteArray) -> ByteArray {
    panic!("return a message for the given log level")
}

pub fn info(message: ByteArray) -> ByteArray {
    panic!("return a message for info log level")
}

pub fn warn(message: ByteArray) -> ByteArray {
    panic!("return a message for warn log level")
}

pub fn error(message: ByteArray) -> ByteArray {
    panic!("return a message for error log level")
}
