pub fn distance(strand1: ByteArray, strand2: ByteArray) -> u256 {
    if strand1.len() != strand2.len() {
        panic!("strands must be of equal length");
    }

    let mut count = 0;

    let mut i = 0;
    loop {
        if i >= strand1.len() {
            break;
        }

        if strand1[i] != strand2[i] {
            count += 1;
        }

        i += 1;
    };

    return count;
}
