use core::dict::{Felt252Dict, Felt252DictEntryTrait};

pub fn proteins(strand: ByteArray) -> Array<ByteArray> {
    let mut result: Array<ByteArray> = array![];
    let mut codons_map = codons_map();

    let mut stopped = false;
    let mut codon_index = 0;
    while let Option::Some(codon) = codon_chunk(@strand, codon_index) {
        let name = name_for_codon(ref codons_map, codon);
        if name == "" {
            break;
        } else if name == "STOP" {
            stopped = true;
            break;
        } else {
            result.append(name);
            codon_index += 3;
        }
    };

    assert(codon_index >= strand.len() || stopped, 'Invalid codon');

    result
}

fn codons_map() -> Felt252Dict<Nullable<ByteArray>> {
    let mut codons_map: Felt252Dict<Nullable<ByteArray>> = Default::default();
    codons_map.insert('AUG', NullableTrait::new("Methionine"));
    codons_map.insert('UUU', NullableTrait::new("Phenylalanine"));
    codons_map.insert('UUC', NullableTrait::new("Phenylalanine"));
    codons_map.insert('UUA', NullableTrait::new("Leucine"));
    codons_map.insert('UUG', NullableTrait::new("Leucine"));
    codons_map.insert('UCU', NullableTrait::new("Serine"));
    codons_map.insert('UCC', NullableTrait::new("Serine"));
    codons_map.insert('UCA', NullableTrait::new("Serine"));
    codons_map.insert('UCG', NullableTrait::new("Serine"));
    codons_map.insert('UAU', NullableTrait::new("Tyrosine"));
    codons_map.insert('UAC', NullableTrait::new("Tyrosine"));
    codons_map.insert('UGU', NullableTrait::new("Cysteine"));
    codons_map.insert('UGC', NullableTrait::new("Cysteine"));
    codons_map.insert('UGG', NullableTrait::new("Tryptophan"));
    codons_map.insert('UAA', NullableTrait::new("STOP"));
    codons_map.insert('UAG', NullableTrait::new("STOP"));
    codons_map.insert('UGA', NullableTrait::new("STOP"));
    codons_map
}

const TWO_POW_8: u32 = 0x100;
const TWO_POW_16: u32 = 0x10000;

fn byte_to_felt252(codon: ByteArray) -> felt252 {
    (codon[0].into() * TWO_POW_16 + codon[1].into() * TWO_POW_8 + codon[2].into()).into()
}

fn name_for_codon(ref self: Felt252Dict<Nullable<ByteArray>>, codon: ByteArray) -> ByteArray {
    let codon = byte_to_felt252(codon);
    let (entry, _name) = self.entry(codon);
    let name = _name.deref_or("");
    let res = name.clone();
    self = entry.finalize(NullableTrait::new(name));
    res
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
