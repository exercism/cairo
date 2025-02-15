// Returns a welcome message for the customer.
pub fn welcome_message(customer: felt252) -> ByteArray {
    "Welcome to the Tech Palace, JUDY"
}

// Adds a border to a welcome message.
pub fn add_border(welcome_msg: ByteArray, num_stars_per_line: u32) -> ByteArray {
    panic!("implement `add_border`")
}

// Cleans up an old marketing message.
pub fn clean_up_message(old_msg: ByteArray) -> ByteArray {
    panic!("implement `CleanupMessage`")
}
