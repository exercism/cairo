#[derive(Destruct)]
struct CodonsInfo {}

pub fn parse(pairs: Array<(felt252, ByteArray)>) -> CodonsInfo {
    // constructs a new CodonsInfo struct
    panic!("implement `parse`")
}

#[generate_trait]
pub impl CodonsInfoImpl of CodonsInfoTrait {
    fn name_for(ref self: CodonsInfo, codon: felt252) -> ByteArray {
        // return name for {codon}
        panic!("implement `name_for`")
    }

    fn of_rna(ref self: CodonsInfo, strand: ByteArray) -> Option<Array<ByteArray>> {
        // return the array of codon names that correspond to the given strand of RNA (represented as a string of codons)
        panic!("implement `of_rna`")
    }
}
