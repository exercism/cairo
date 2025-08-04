pub fn clean(phrase: ByteArray) -> ByteArray {
    let mut cleaned: ByteArray = "";

    let mut i = 0;
    while i < phrase.len() {
        let c = phrase[i];

        assert_valid(c);
        if is_numeric(c) {
            cleaned.append_byte(c);
        }

        i += 1;
    }

    assert!(cleaned.len() >= 10, "must not be fewer than 10 digits");

    if cleaned.len() == 11 {
        assert!(cleaned[0] == '1', "11 digits must start with 1");

        let mut sliced = "";
        let mut i = 1;

        while i < cleaned.len() {
            sliced.append_byte(cleaned[i]);
            i += 1;
        }

        cleaned = sliced.clone();
    }

    assert!(cleaned.len() <= 11, "must not be greater than 11 digits");
    assert!(cleaned[0] != '0', "area code cannot start with zero");
    assert!(cleaned[0] != '1', "area code cannot start with one");
    assert!(cleaned[3] != '0', "exchange code cannot start with zero");
    assert!(cleaned[3] != '1', "exchange code cannot start with one");

    cleaned
}


fn assert_valid(c: u8) {
    assert!(!is_alphabetic(c), "letters not permitted");
    assert!(is_numeric(c) || is_allowed_punctuation(c), "punctuations not permitted");
}

fn is_alphabetic(c: u8) -> bool {
    c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z'
}

fn is_numeric(c: u8) -> bool {
    c >= '0' && c <= '9'
}

fn is_allowed_punctuation(c: u8) -> bool {
    c == '(' || c == ')' || c == '-' || c == ' ' || c == '.' || c == '+'
}
