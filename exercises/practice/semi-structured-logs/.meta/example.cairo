#[derive(Drop)]
enum LogLevel {
    Info,
    Warning,
    Error,
    Debug,
}

fn log(level: LogLevel, message: ByteArray) -> ByteArray {
    match level {
        LogLevel::Info => info(message),
        LogLevel::Warning => warn(message),
        LogLevel::Error => error(message),
        LogLevel::Debug => format!("[DEBUG]: {message}"),
    }
}

fn info(message: ByteArray) -> ByteArray {
    format!("[INFO]: {message}")
}

fn warn(message: ByteArray) -> ByteArray {
    format!("[WARNING]: {message}")
}

fn error(message: ByteArray) -> ByteArray {
    format!("[ERROR]: {message}")
}
