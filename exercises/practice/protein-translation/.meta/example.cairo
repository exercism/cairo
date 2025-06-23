use core::dict::Felt252Dict;
use core::nullable::{match_nullable, FromNullableResult};

#[derive(Drop, Debug, PartialEq, Copy)]
pub enum AminoAcid {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
}

#[derive(Drop, Copy)]
enum Codon {
    AminoAcid: AminoAcid,
    Stop,
}

pub fn proteins(strand: ByteArray) -> Array<AminoAcid> {
    let mut result: Array<AminoAcid> = array![];
    let mut codons_map = codons_map();

    let mut stopped = false;
    let mut codon_index = 0;
    while let Option::Some(codon) = codon_chunk(@strand, codon_index) {
        match match_nullable(codons_map.get(byte_to_felt252(codon))) {
            FromNullableResult::Null => { break; },
            FromNullableResult::NotNull(codon) => {
                let codon = codon.unbox();
                match codon {
                    Codon::Stop => {
                        stopped = true;
                        break;
                    },
                    Codon::AminoAcid(amino_acid) => {
                        result.append(amino_acid);
                        codon_index += 3;
                    },
                }
            },
        }
    };

    assert!(codon_index >= strand.len() || stopped, "Invalid codon");

    result
}

fn codons_map() -> Felt252Dict<Nullable<Codon>> {
    let mut codons_map: Felt252Dict<Nullable<Codon>> = Default::default();
    codons_map.insert('AUG', NullableTrait::new(Codon::AminoAcid(AminoAcid::Methionine)));
    codons_map.insert('UUU', NullableTrait::new(Codon::AminoAcid(AminoAcid::Phenylalanine)));
    codons_map.insert('UUC', NullableTrait::new(Codon::AminoAcid(AminoAcid::Phenylalanine)));
    codons_map.insert('UUA', NullableTrait::new(Codon::AminoAcid(AminoAcid::Leucine)));
    codons_map.insert('UUG', NullableTrait::new(Codon::AminoAcid(AminoAcid::Leucine)));
    codons_map.insert('UCU', NullableTrait::new(Codon::AminoAcid(AminoAcid::Serine)));
    codons_map.insert('UCC', NullableTrait::new(Codon::AminoAcid(AminoAcid::Serine)));
    codons_map.insert('UCA', NullableTrait::new(Codon::AminoAcid(AminoAcid::Serine)));
    codons_map.insert('UCG', NullableTrait::new(Codon::AminoAcid(AminoAcid::Serine)));
    codons_map.insert('UAU', NullableTrait::new(Codon::AminoAcid(AminoAcid::Tyrosine)));
    codons_map.insert('UAC', NullableTrait::new(Codon::AminoAcid(AminoAcid::Tyrosine)));
    codons_map.insert('UGU', NullableTrait::new(Codon::AminoAcid(AminoAcid::Cysteine)));
    codons_map.insert('UGC', NullableTrait::new(Codon::AminoAcid(AminoAcid::Cysteine)));
    codons_map.insert('UGG', NullableTrait::new(Codon::AminoAcid(AminoAcid::Tryptophan)));
    codons_map.insert('UAA', NullableTrait::new(Codon::Stop));
    codons_map.insert('UAG', NullableTrait::new(Codon::Stop));
    codons_map.insert('UGA', NullableTrait::new(Codon::Stop));
    codons_map
}

fn codon_chunk(self: @ByteArray, from: u32) -> Option<ByteArray> {
    if let Option::Some(char) = self.at(from + 2) {
        let mut codon = "";
        codon.append_byte(self[from]);
        codon.append_byte(self[from + 1]);
        codon.append_byte(char);
        Option::Some(codon)
    } else {
        Option::None
    }
}

const TWO_POW_8: u32 = 0x100;
const TWO_POW_16: u32 = 0x10000;

fn byte_to_felt252(codon: ByteArray) -> felt252 {
    (codon[0].into() * TWO_POW_16 + codon[1].into() * TWO_POW_8 + codon[2].into()).into()
}
