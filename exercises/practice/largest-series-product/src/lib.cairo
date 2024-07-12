#[derive(Drop, Debug, PartialEq)]
enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
}

fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    panic!("implement the 'lsp' function")
}

#[cfg(test)]
mod tests;
