use core::dict::Felt252Dict;

pub fn is_isogram(phrase: ByteArray) -> bool {
    let mut seen: Felt252Dict<bool> = Default::default();

    let mut success = true;
    let mut i = 0;
    while i < phrase.len() {
        let chr = lowercase(phrase[i]);
        if seen.get(chr.into()) {
            success = false;
            break;
        }

        if chr >= 'a' && chr <= 'z' {
            seen.insert(chr.into(), true);
        }

        i += 1;
    }

    success
}

pub fn lowercase(chr: u8) -> u8 {
    if chr >= 'A' && chr <= 'Z' {
        chr + 32
    } else {
        chr
    }
}
