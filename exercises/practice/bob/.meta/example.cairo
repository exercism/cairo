pub fn response(input: @ByteArray) -> ByteArray {
    if is_silent(input) {
        "Fine. Be that way!"
    } else if is_loud_question(input) {
        "Calm down, I know what I'm doing!"
    } else if is_loud_statement(input) {
        "Whoa, chill out!"
    } else if is_question(input) {
        "Sure."
    } else {
        "Whatever."
    }
}


fn is_loud_question(input: @ByteArray) -> bool {
    is_question(input) && is_loud(input)
}

fn is_loud_statement(input: @ByteArray) -> bool {
    is_loud(input)
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
    }
    has_letter && @uppercased == input
}

fn is_question(input: @ByteArray) -> bool {
    let trimmed = trim(input);
    let last = trimmed[trimmed.len() - 1];

    last == '?'
}

fn is_silent(input: @ByteArray) -> bool {
    trim(input) == ""
}

fn is_letter(c: u8) -> bool {
    is_uppercase(c) || is_lowercase(c)
}

fn is_lowercase(c: u8) -> bool {
    c >= 'a' && c <= 'z'
}

fn is_uppercase(c: u8) -> bool {
    c >= 'A' && c <= 'Z'
}

fn to_uppercase(c: u8) -> u8 {
    if is_lowercase(c) {
        c - 32
    } else {
        c
    }
}

fn is_whitespace(c: u8) -> bool {
    c == ' ' || c == '\t' || c == '\n' || c == '\r'
}

fn trim(input: @ByteArray) -> ByteArray {
    if input.len() == 0 {
        return "";
    }

    let mut result = "";
    let mut start = 0;
    while start < input.len() && is_whitespace(input[start]) {
        start += 1;
    }

    let mut end = input.len() - 1;
    while end >= start {
        if !is_whitespace(input[end]) {
            break;
        }

        end -= 1;
    }

    let mut j = start;
    while j <= end {
        result.append_byte(input[j]);
        j += 1;
    }

    result
}
