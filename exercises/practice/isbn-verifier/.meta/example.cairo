pub fn is_valid(isbn: ByteArray) -> bool {
    // Step 1: Remove dashes and ensure only valid characters are left.
    let filtered_isbn = filter(isbn);
    let size = filtered_isbn.len();

    // Step 2: Check length of valid characters.
    if size != 10 {
        return false;
    }

    // Step 3: Calculate the sum based on the formula.
    let mut i = 0;
    let mut sum: u32 = 0;
    let mut valid = true;

    while i < size {
        match char_to_digit(filtered_isbn[i]) {
            Option::Some(digit) => {
                if digit == 10 && i < 9 {
                    valid = false;
                    break;
                }
                sum += digit.into() * (10 - i);
            },
            Option::None => {
                valid = false;
                break;
            },
        }
        i += 1;
    };

    // Step 4: Return true if valid (sum % 11 == 0).
    valid && sum % 11 == 0
}

fn filter(isbn: ByteArray) -> ByteArray {
    let mut filtered_isbn = "";
    let mut i = 0;
    while i < isbn.len() {
        if isbn[i] != '-' {
            filtered_isbn.append_byte(isbn[i]);
        }
        i += 1;
    };
    filtered_isbn
}

fn char_to_digit(c: u8) -> Option<u8> {
    let zero_ascii = '0';
    let nine_ascii = '9';

    if c >= zero_ascii && c <= nine_ascii {
        Option::Some(c - zero_ascii)
    } else if c == 'X' {
        Option::Some(10)
    } else {
        Option::None
    }
}
