const DISTANCE_BETWEEN_CASES: u8 = 'a' - 'A';
const MAX_ENCODED_CHAR: u8 = 'a' + 'z';    

pub fn encode(phrase: ByteArray) -> ByteArray {
    let mut result = "";
    let mut chunk_size = 0;
    let mut i = 0;
    while i < phrase.len() {
        let chr = phrase[i];
        if is_alphanumeric(chr) {
            if chunk_size == 5 {
                result += " ";
                chunk_size = 0;
            }
            let encoded = encode_char(chr);
            result.append_byte(encoded);
            chunk_size += 1;
        }
        i += 1;
    };

    result
}


pub fn decode(phrase: ByteArray) -> ByteArray {
    let mut result = "";
    let mut i = 0;
    while i < phrase.len() {
        let chr = phrase[i];
        if !is_whitespace(chr) {
            let decoded = encode_char(chr);
            result.append_byte(decoded);
        }
        i += 1;
    };
    result
}

fn encode_char(chr: u8) -> u8 {
    if is_letter(chr) {
        MAX_ENCODED_CHAR - lowercase(chr)
    } else {
        chr
    }
}

fn is_alphanumeric(chr: u8) -> bool {
    is_letter(chr) || is_numeric(chr)
}

fn is_numeric(chr: u8) -> bool {
    chr >= '0' && chr <= '9'
}

fn is_letter(chr: u8) -> bool {
    is_lower(chr) || is_upper(chr)
}

fn is_lower(chr: u8) -> bool {
    chr >= 'a' && chr <= 'z'
}

fn is_upper(chr: u8) -> bool {
    chr >= 'A' && chr <= 'Z'
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
}

fn lowercase(chr: u8) -> u8 {
    if is_upper(chr) {
        chr + DISTANCE_BETWEEN_CASES
    } else {
        chr
    }
}
