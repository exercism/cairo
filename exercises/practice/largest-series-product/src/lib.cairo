#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
    IndexOutOfBounds
}

pub fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    panic!("implement largest series product")
}

#[cfg(test)]
mod tests;
