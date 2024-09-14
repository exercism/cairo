#[derive(Drop, Debug, PartialEq)]
pub enum Proteins {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
    STOP
}

pub fn proteins(strand: ByteArray) -> Array<Proteins> {
    panic!("implement 'proteins'")
}
