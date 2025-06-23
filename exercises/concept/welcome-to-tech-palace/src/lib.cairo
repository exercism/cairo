// Returns a welcome message for the customer.
pub fn welcome_message(customer: felt252) -> ByteArray {
    panic!("implement `welcome_message`")
}

// Adds a border to a welcome message.
pub fn add_border(welcome_msg: ByteArray, num_stars_per_line: u32) -> ByteArray {
    panic!("implement `add_border`")
}

// Cleans up an old marketing message.
pub fn clean_up_message(old_msg: ByteArray) -> ByteArray {
    panic!("implement `clean_up_message`")
}

///////////////
/// Helpers ///
///////////////

// Distance between a lowercase and uppercase representations
// of the same character in the ASCII table
const ASCII_CASE_OFFSET: u8 = 32;
const BYTE_SIZE: u256 = 256; // 2^8, number of possible values in a byte
const BYTE_MASK: u256 = 0xff; // Mask to extract the last byte (8 bits)

fn to_uppercase(input: u256) -> ByteArray {
    let mut remaining_bytes = input;
    let mut uppercase_chars: ByteArray = "";
    while remaining_bytes != 0 {
        uppercase_chars.append_byte(char_to_uppercase(get_last_byte(remaining_bytes)));
        remaining_bytes = remove_last_byte(remaining_bytes);
    };
    uppercase_chars.rev()
}

fn get_last_byte(chars: u256) -> u8 {
    (chars & BYTE_MASK.into()).try_into().unwrap()
}

fn remove_last_byte(chars: u256) -> u256 {
    chars / BYTE_SIZE.into()
}

fn char_to_uppercase(c: u8) -> u8 {
    if is_lowercase(c) {
        c - ASCII_CASE_OFFSET
    } else {
        c
    }
}

fn is_lowercase(c: u8) -> bool {
    // This comparison is valid because the type of the value in the short
    // string format gets automatically inferred by the compiler
    c >= 'a' && c <= 'z'
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
}
