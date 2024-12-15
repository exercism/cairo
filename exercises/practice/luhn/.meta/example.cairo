// Utility function to convert a char representing a digit into its numerical value (u32 equivalent)
fn char_to_digit(c: u8) -> Option<u8> {
    let zero_ascii = '0';
    let nine_ascii = '9';

    if c >= zero_ascii && c <= nine_ascii {
        Option::Some(c - zero_ascii)
    } else {
        Option::None // Return None for invalid characters
    }
}

// Function to validate a number using the Luhn algorithm
pub fn valid(candidate: ByteArray) -> bool {
    let mut count_digits = 0_u32;
    let mut processed_digits_sum = 0_u32;
    let mut should_double = false;
    let mut valid = true;

    // Iterate over characters from right to left
    let mut i = candidate.len();
    while i != 0 {
        i -= 1;

        let c = candidate[i];

        // Skip spaces
        if c == ' ' {
            continue;
        }

        // Convert char to digit and check validity
        let digit = match char_to_digit(c) {
            Option::Some(val) => val,
            Option::None => {
                valid = false;
                break;
            },
        };

        // Process digit according to Luhn's algorithm
        if should_double {
            let mut doubled = digit * 2;
            if doubled > 9 {
                doubled -= 9;
            }
            processed_digits_sum += doubled.into();
        } else {
            processed_digits_sum += digit.into();
        }

        // Flip should_double for alternating digits
        should_double = !should_double;
        count_digits += 1;
    };

    valid && count_digits > 1 && processed_digits_sum % 10 == 0
}
