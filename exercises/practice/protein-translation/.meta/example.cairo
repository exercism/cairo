use core::num::traits::zero::Zero;

#[derive(Destruct)]
struct CodonsInfo {
    actual_codons: Felt252Dict<felt252>,
}

enum TranslateResult {
    Invalid,
    Stopped,
    Ok
}

fn parse(pairs: Array<(felt252, felt252)>) -> CodonsInfo {
    let mut pairs = pairs;
    let mut actual_codons: Felt252Dict<felt252> = Default::default();
    while let Option::Some((codon, name)) = pairs
        .pop_front() {
            actual_codons.insert(codon, name);
        };
    CodonsInfo { actual_codons, }
}

#[generate_trait]
impl CodonsInfoImpl of CodonsInfoTrait {
    fn name_for(ref self: CodonsInfo, codon: felt252) -> felt252 {
        self.actual_codons.get(codon)
    }

    fn of_rna(ref self: CodonsInfo, strand: ByteArray) -> Option<Array<felt252>> {
        let mut result: Array<felt252> = array![];

        let mut codon_index = 0;
        let translate_result = loop {
            if codon_index == strand.len() {
                break TranslateResult::Ok;
            }

            if let Option::Some(codon) = strand.codon_from(codon_index) {
                let name = self.name_for(codon);
                if name.is_zero() {
                    break TranslateResult::Invalid;
                } else if name == 'stop codon' {
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
impl ByteArrayChunk of ChunkTrait {
    fn codon_from(self: @ByteArray, from: usize) -> Option<felt252> {
        if let Option::Some(char) = self.at(from + 2) {
            let chunk = char.into()
                + self[from
                + 1].into() * TWO_POW_8
                + self[from].into() * TWO_POW_16;
            Option::Some(chunk.into())
        } else {
            Option::None
        }
    }
}

#[cfg(test)]
mod tests;
