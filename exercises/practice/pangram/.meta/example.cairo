pub fn is_pangram(sentence: ByteArray) -> bool {
    let mut seen: Felt252Dict<bool> = Default::default();

    let mut i = 0;
    while i < sentence
        .len() {
            let chr = sentence[i];
            if chr >= 'A' && chr <= 'Z' {
                seen.insert((chr + 32).into(), true);
            } else if chr >= 'a' && chr <= 'z' {
                seen.insert(chr.into(), true);
            }
            i += 1;
        };

    let mut success = true;
    let mut curr: u8 = 'a';
    while curr <= 'z' {
        if !seen.get(curr.into()) {
            success = false;
            break;
        }

        curr += 1;
    };

    return success;
}
