#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
}

pub fn lsp(string_digits: @ByteArray, span: usize) -> Result<u64, Error> {
    panic!("largest series product of a span of {span} digits in {string_digits}")
}

#[cfg(test)]
mod tests;
