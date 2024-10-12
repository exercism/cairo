#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn rebase(digits: Array<u32>, inputBase: u32, outputBase: u32) -> Result<Array<u32>, Error> {
    panic!("implement `convert`")
}
