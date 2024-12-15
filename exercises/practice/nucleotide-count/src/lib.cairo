#[derive(Debug, Drop, PartialEq)]
pub struct Counter {
    pub a: u64,
    pub c: u64,
    pub g: u64,
    pub t: u64,
}

pub fn counts(strand: ByteArray) -> Counter {
    panic!("implement `counts`")
}
