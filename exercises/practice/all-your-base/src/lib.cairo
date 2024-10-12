#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn convert(number: Array<u32>, from_base: u32, to_base: u32) -> Result<Array<u32>, Error> {
    panic!("implement `convert`")
}
