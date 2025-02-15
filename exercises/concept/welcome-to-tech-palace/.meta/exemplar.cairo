// Returns a welcome message for the customer.
pub fn welcome_message(customer: felt252) -> ByteArray {
    "Welcome to the Tech Palace, " + to_uppercase(customer)
}

// Adds a border to a welcome message.
pub fn add_border(welcome_msg: ByteArray, num_stars_per_line: u32) -> ByteArray {
    let mut border: ByteArray = "";
    for _ in 0..num_stars_per_line {
        border.append_byte('*');
    };
    border.clone() + "\n" + welcome_msg + "\n" + border
}

// Cleans up an old marketing message.
pub fn clean_up_message(old_msg: ByteArray) -> ByteArray {
    panic!("implement `CleanupMessage`")
}

///////////////
/// Helpers ///
///////////////

// Distance between a lowercase and uppercase representations
// of the same character in the ASCII table
const LOWER_TO_UPPER_ASCII_DISTANCE: u8 = 32;
const NUM_OF_ASCII_CHARS: u256 = 255;

fn to_uppercase(customer: felt252) -> ByteArray {
    let word_len = get_word_len(customer);
    let mut customer_bytearray: ByteArray = "";
    customer_bytearray.append_word(customer, word_len);
    let mut uppercase_customer: ByteArray = "";
    let mut i = 0;
    while i < customer_bytearray.len() {
        let c = customer_bytearray[i];
        if is_lowercase(c) {
            uppercase_customer.append_byte(c - LOWER_TO_UPPER_ASCII_DISTANCE);
        } else {
            uppercase_customer.append_byte(c);
        }
        i += 1;
    };
    uppercase_customer
}

fn get_word_len(word: felt252) -> usize {
    // we convert to u256 for the following division(s)
    let mut word: u256 = word.into();
    let mut len = 1;
    while word / NUM_OF_ASCII_CHARS != 0 {
        word /= NUM_OF_ASCII_CHARS;
        len += 1;
    };
    len
}

fn is_lowercase(c: u8) -> bool {
    // This comparison is valid because the type of short strings gets
    // automatically inferred by the compiler
    c >= 'a' && c <= 'z'
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
}
