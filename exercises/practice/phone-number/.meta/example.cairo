pub fn clean(phrase: ByteArray) -> ByteArray {
    let mut cleaned: ByteArray = "";

    let mut i = 0;
    while i < phrase.len() {
        let c = phrase[i];
        i += 1;
        if c >= '0' && c <= '9' {
            cleaned.append_byte(c);
        } else if c == '(' || c == ')' || c == '-' || c == ' ' || c == '.' || c == '+' {
            continue;
        } else if (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') {
            panic!("letters not permitted");
        } else {
            panic!("punctuations not permitted");
        }
    };

    if cleaned.len() < 10 {
        panic!("must not be fewer than 10 digits");
    }

    if cleaned.len() == 11 {
        if cleaned[0] != '1' {
            panic!("11 digits must start with 1");
        }

        let mut sliced = "";
        let mut i = 1;

        while i < cleaned.len() {
            if i == 0 {
                i += 1;
                continue;
            }
            sliced.append_byte(cleaned[i]);
            i += 1;
        };

        cleaned = sliced.clone();
    } else if cleaned.len() > 11 {
        panic!("must not be greater than 11 digits");
    }

    if cleaned[0] == '0' {
        panic!("area code cannot start with zero");
    }
    if cleaned[0] == '1' {
        panic!("area code cannot start with one");
    }

    if cleaned[3] == '0' {
        panic!("exchange code cannot start with zero");
    }

    if cleaned[3] == '1' {
        panic!("exchange code cannot start with one");
    }

    return cleaned;
}
