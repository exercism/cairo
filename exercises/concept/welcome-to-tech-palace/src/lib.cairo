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
    panic!("implement `CleanupMessage`")
}

///////////////
/// Helpers ///
///////////////

// Distance between a lowercase and uppercase representations
// of the same character in the ASCII table
const LOWER_TO_UPPER_ASCII_DISTANCE: u8 = 32;

fn to_uppercase(c: u8) -> u8 {
    if is_uppercase(c) {
        c
    } else {
        c - LOWER_TO_UPPER_ASCII_DISTANCE
    }
}

fn is_uppercase(c: u8) -> bool {
    // This comparison is valid because the type of short strings gets
    // automatically inferred by the compiler
    c >= 'A' && c <= 'Z'
}
