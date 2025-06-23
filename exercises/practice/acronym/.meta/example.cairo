pub fn abbreviate(phrase: ByteArray) -> ByteArray {
    let mut result = "";

    let mut i = 0;
    let mut capture = true;
    while i < phrase.len() {
        let c = phrase[i];
        if c == ' ' || c == '-' || c == '_' {
            capture = true;
        } else if capture && is_letter(c) {
            result.append_byte(to_uppercase(c));
            capture = false;
        }
        i += 1;
    };

    result
}

fn to_uppercase(c: u8) -> u8 {
    if is_lowercase(c) {
        c - 32
    } else {
        c
    }
}

fn is_letter(c: u8) -> bool {
    is_uppercase(c) || is_lowercase(c)
}

fn is_uppercase(c: u8) -> bool {
    c >= 'A' && c <= 'Z'
}

fn is_lowercase(c: u8) -> bool {
    c >= 'a' && c <= 'z'
}
