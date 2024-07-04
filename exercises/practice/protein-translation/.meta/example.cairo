use core::num::traits::zero::Zero;

#[derive(Destruct)]
pub struct CodonsInfo {
    actual_codons: Felt252Dict<felt252>,
}

pub fn parse(pairs: Array<(felt252, felt252)>) -> CodonsInfo {
    let mut pairs = pairs;
    let mut actual_codons: Felt252Dict<felt252> = Default::default();
    while let Option::Some((codon, name)) = pairs
        .pop_front() {
            actual_codons.insert(codon, name);
        };
    CodonsInfo { actual_codons, }
}

const TWO_POW_8: u32 = 0x100;
const TWO_POW_16: u32 = 0x10000;

#[generate_trait]
impl CodonsInfoImpl of CodonsInfoTrait {
    fn name_for(ref self: CodonsInfo, codon: felt252) -> felt252 {
        self.actual_codons.get(codon)
    }

    fn of_rna(ref self: CodonsInfo, strand: ByteArray) -> Option<Array<felt252>> {
        let mut result: Array<felt252> = array![];

        let len = strand.len();
        let mut stopped = false;
        let mut invalid = false;
        let mut i = 0;
        while i < len {
            let mut codon: u32 = strand[i].into() * TWO_POW_16;
            i += 1;
            if let Option::Some(char) = strand.at(i) {
                codon += char.into() * TWO_POW_8;
            } else {
                invalid = true;
                break;
            }
            i += 1;
            if let Option::Some(char) = strand.at(i) {
                codon += char.into();
            } else {
                invalid = true;
                break;
            }

            let name = self.name_for(codon.into());
            if name.is_zero() {
                break;
            } else if name == 'stop codon' {
                stopped = true;
                break;
            }
            result.append(name);

            i += 1;
        };

        if i < len {
            if stopped {
                return Option::Some(result);
            } else {
                return Option::None;
            }
        } else if invalid {
            return Option::None;
        } else {
            return Option::Some(result);
        }
    }
}

#[cfg(test)]
mod tests;
