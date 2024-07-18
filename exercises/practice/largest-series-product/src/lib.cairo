#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
}

pub fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    panic!("implement the 'lsp' function")
}
