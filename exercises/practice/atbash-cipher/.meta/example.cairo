pub fn encode(phrase: ByteArray) -> ByteArray {
    let mut result = "";

    let mut i = 0;
    let mut chunk_size = 0;
    while i < phrase.len() {
        let chr = phrase[i];

        if is_whitespace(chr) || is_punctuation(chr) {
            i += 1;
            continue;
        }

        if chunk_size == 5 {
            result += " ";
            chunk_size = 0;
        }

        let mut encoded = chr;
        if is_letter(chr) {
            encoded = 'a' + 'z' - lowercase(chr);
        }

        result.append_byte(encoded);
        chunk_size += 1;
        i += 1;
    };

    result
}


pub fn decode(phrase: ByteArray) -> ByteArray {
    let mut result = "";

    let mut i = 0;
    while i < phrase.len() {
        let chr = phrase[i];

        if is_whitespace(chr) {
            i += 1;
            continue;
        }

        let mut decoded = chr;
        if is_letter(chr) {
            decoded = 'a' + 'z' - lowercase(chr);
        }

        result.append_byte(decoded);
        i += 1;
    };

    result
}

fn is_letter(chr: u8) -> bool {
    (chr >= 'a' && chr <= 'z') || (chr >= 'A' && chr <= 'Z')
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
}

fn is_punctuation(chr: u8) -> bool {
    (chr >= '!' && chr <= '/')
        || (chr >= ':' && chr <= '@')
        || (chr >= '[' && chr <= '`')
        || (chr >= '{' && chr <= '~')
}

fn lowercase(chr: u8) -> u8 {
    if chr >= 'A' && chr <= 'Z' {
        chr + 'a' - 'A'
    } else {
        chr
    }
}
