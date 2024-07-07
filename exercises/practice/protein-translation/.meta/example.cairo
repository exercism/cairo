use core::dict::Felt252DictEntryTrait;
use core::num::traits::zero::Zero;

#[derive(Destruct)]
struct CodonsInfo {
    actual_codons: Felt252Dict<Nullable<ByteArray>>,
}

enum TranslateResult {
    Invalid,
    Stopped,
    Ok
}

fn parse(pairs: Array<(felt252, ByteArray)>) -> CodonsInfo {
    let mut pairs = pairs;
    let mut actual_codons: Felt252Dict<Nullable<ByteArray>> = Default::default();
    while let Option::Some((codon, name)) = pairs
        .pop_front() {
            actual_codons.insert(codon, NullableTrait::new(name));
        };
    CodonsInfo { actual_codons, }
}

#[generate_trait]
impl CodonsInfoImpl of CodonsInfoTrait {
    fn name_for(ref self: CodonsInfo, codon: felt252) -> ByteArray {
        let (entry, _name) = self.actual_codons.entry(codon);
        let name = _name.deref_or("");
        let res = name.clone();
        self.actual_codons = entry.finalize(NullableTrait::new(name));
        res
    }

    fn of_rna(ref self: CodonsInfo, strand: ByteArray) -> Option<Array<ByteArray>> {
        let mut result: Array<ByteArray> = array![];

        let mut codon_index = 0;
        let translate_result = loop {
            if codon_index == strand.len() {
                break TranslateResult::Ok;
            }

            if let Option::Some(codon) = strand.codon_chunk(codon_index) {
                let name = self.name_for(codon);
                if name == "" {
                    break TranslateResult::Invalid;
                } else if name == "stop codon" {
                    break TranslateResult::Stopped;
                }

                result.append(name);
                codon_index += 3;
            } else {
                break TranslateResult::Invalid;
            }
        };

        match translate_result {
            TranslateResult::Invalid => Option::None,
            _ => Option::Some(result)
        }
    }
}

const TWO_POW_8: u32 = 0x100;
const TWO_POW_16: u32 = 0x10000;

#[generate_trait]
impl CodonChunk of CodonChunkTrait {
    /// Given a ByteArray, extracts a codon from a given index `from`.
    /// Needs to extract 3 ByteArray characters and convert them to the appropriate
    /// felt252 value. It does this by taking the characters' byte value and moving
    /// their bits to the left depending on their position in the codon.
    /// 
    /// Example:
    /// 1. Method call: "AUG".codon_chunk(0)
    /// 2. Chars and their byte (hex) values:
    ///    - "A" = 0x41
    ///    - "U" = 0x55
    ///    - "G" = 0x47 
    /// 3. "A" is the leftmost character, so we "move" it 2 bytes to the left by
    ///    multiplying it by 2^16 (hex value: 0x10000)
    /// 4. "U" is the middle character, so we "move" it 1 byte to the left by
    ///    multiplying it by 2^8 (hex value: 0x100)
    /// 5. "G" is the rightmost character, so we leave it in place
    /// 6. Codon = "A" * 2^16 + "U" * 2^8 + "G"
    ///          = 0x41 * 0x10000 + 0x55 * 0x100 * 0x47
    ///          = 0x415547
    /// 7. (41)(55)(47) are hex values for (A)(U)(G)
    /// 
    /// Returns:
    /// - Option::Some(codon) -> if the extraction was successful
    /// - Option::None -> if the ByteArray was too short from the given index
    fn codon_chunk(self: @ByteArray, from: usize) -> Option<felt252> {
        if let Option::Some(char) = self.at(from + 2) {
            let codon = char.into()
                + self[from
                + 1].into() * TWO_POW_8
                + self[from].into() * TWO_POW_16;
            Option::Some(codon.into())
        } else {
            Option::None
        }
    }
}

#[cfg(test)]
mod tests;
