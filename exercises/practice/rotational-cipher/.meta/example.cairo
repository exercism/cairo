pub fn rotate(text: ByteArray, shift_key: u8) -> ByteArray {
    let mut result = "";

    let mut i = 0;

    loop {
        if i == text.len() {
            break;
        }

        let chr = text[i];
        let mut encoded = chr;
        if chr >= 'a' && chr <= 'z' {
            encoded = 'a' + (chr - 'a' + shift_key) % 26;
        } else if chr >= 'A' && chr <= 'Z' {
            encoded = 'A' + (chr - 'A' + shift_key) % 26;
        }
        result.append_byte(encoded);
        i += 1;
    };

    result
}
