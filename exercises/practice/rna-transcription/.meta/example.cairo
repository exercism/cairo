pub fn to_rna(dna: ByteArray) -> ByteArray {
    let mut rna = "";

    let mut i = 0;
    while i < dna
        .len() {
            let nucleotide = dna[i];
            if nucleotide == 'C' {
                rna += "G";
            } else if nucleotide == 'G' {
                rna += "C";
            } else if nucleotide == 'T' {
                rna += "A";
            } else if nucleotide == 'A' {
                rna += "U";
            }
            i += 1;
        }; 

    return rna;
}
