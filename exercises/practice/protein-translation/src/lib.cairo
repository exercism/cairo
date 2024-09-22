#[derive(Drop, Debug, PartialEq)]
pub enum AminoAcid {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
}

pub fn proteins(strand: ByteArray) -> Array<AminoAcid> {
    panic!("implement 'proteins'")
}
