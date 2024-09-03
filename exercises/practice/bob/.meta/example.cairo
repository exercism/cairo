pub fn response(input: @ByteArray) -> ByteArray {
    if is_silent(input) {
        return "Fine. Be that way!";
    }

    if is_loud_question(input) {
        return "Calm down, I know what I'm doing!";
    }

    if is_loud_statement(input) {
        return "Whoa, chill out!";
    }

    if is_question(input) {
        return "Sure.";
    }

    return "Whatever.";
}


fn is_loud_question(input: @ByteArray) -> bool {
    return is_question(input) && is_loud(input);
}

fn is_loud_statement(input: @ByteArray) -> bool {
    return is_loud(input);
}

fn is_loud(input: @ByteArray) -> bool {
    let mut has_letter = false;
    let mut uppercased = "";
    let mut i = 0;
    while i < input.len() {
        let c = input[i];
        if !has_letter && is_letter(c) {
            has_letter = true;
        }

        uppercased.append_byte(to_uppercase(c));
        i += 1;
    };
    return has_letter && @uppercased == input;
}

fn is_question(input: @ByteArray) -> bool {
    let trimmed = trim(input);
    let last = trimmed[trimmed.len() - 1];

    return last == '?';
}

fn is_silent(input: @ByteArray) -> bool {
    return trim(input) == "";
}

fn is_letter(c: u8) -> bool {
    return is_uppercase(c) || is_lowercase(c);
}

fn is_lowercase(c: u8) -> bool {
    return c >= 'a' && c <= 'z';
}

fn is_uppercase(c: u8) -> bool {
    return c >= 'A' && c <= 'Z';
}

fn to_uppercase(c: u8) -> u8 {
    if is_lowercase(c) {
        return c - 32;
    }
    return c;
}

fn is_whitespace(c: u8) -> bool {
    return c == ' ' || c == '\t' || c == '\n' || c == '\r';
}

fn trim(input: @ByteArray) -> ByteArray {
    let mut result = "";
    let mut i = 0;
    while i < input.len() {
        let c = input[i];
        if !is_whitespace(c) {
            result.append_byte(c);
        }
        i += 1;
    };
    return result;
}
