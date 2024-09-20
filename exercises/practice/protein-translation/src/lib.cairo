#[derive(Drop, Debug, PartialEq)]
pub enum Proteins {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
    Stop
}

pub fn proteins(strand: ByteArray) -> Array<Proteins> {
    panic!("implement 'proteins'")
}
