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
    // return a message for the given log level
    panic!("implement `log`")
}

pub fn info(message: ByteArray) -> ByteArray {
    // return a message for info log level
    panic!("implement `info`")
}

pub fn warn(message: ByteArray) -> ByteArray {
    // return a message for warn log level
    panic!("implement `warn`")
}

pub fn error(message: ByteArray) -> ByteArray {
    // return a message for error log level
    panic!("implement `error`")
}
