/// various log levels
#[derive(Drop)]
enum LogLevel {
    Info,
    Warning,
    Error,
    Debug
}

/// primary function for emitting logs
fn log(level: LogLevel, message: ByteArray) -> ByteArray {
    panic!("return a message for the given log level")
}

fn info(message: ByteArray) -> ByteArray {
    panic!("return a message for info log level")
}

fn warn(message: ByteArray) -> ByteArray {
    panic!("return a message for warn log level")
}

fn error(message: ByteArray) -> ByteArray {
    panic!("return a message for error log level")
}

#[cfg(test)]
mod tests;
