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
    panic!("implement `log`: returns a message for the given log level")
}

pub fn info(message: ByteArray) -> ByteArray {
    panic!("implement `info`: returns a message for info log level")
}

pub fn warn(message: ByteArray) -> ByteArray {
    panic!("implement `warn`: returns a message for warn log level")
}

pub fn error(message: ByteArray) -> ByteArray {
    panic!("implement `error`: returns a message for error log level")
}
