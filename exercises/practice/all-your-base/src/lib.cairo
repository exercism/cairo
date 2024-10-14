#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn rebase(digits: Array<u32>, input_base: u32, output_base: u32) -> Result<Array<u32>, Error> {
    panic!("implement `convert`")
}
