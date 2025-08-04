#[derive(Debug, Default, Drop, PartialEq)]
pub struct Counter {
    pub a: u64,
    pub c: u64,
    pub g: u64,
    pub t: u64,
}

pub fn counts(strand: ByteArray) -> Counter {
    let mut counter: Counter = Default::default();
    let mut i = 0;

    while i < strand.len() {
        let chr = strand[i];
        if chr == 'A' {
            counter.a += 1;
        } else if chr == 'C' {
            counter.c += 1;
        } else if chr == 'G' {
            counter.g += 1;
        } else if chr == 'T' {
            counter.t += 1;
        } else {
            panic!("Invalid nucleotide in strand");
        }
        i += 1;
    }

    counter
}
