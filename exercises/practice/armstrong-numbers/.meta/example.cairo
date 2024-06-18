use core::integer::{u32_overflowing_add};

fn is_armstrong_number(num: u32) -> bool {
    let s = format!("{}", num);
    let l = s.len();
    let mut result: Option<u32> = Option::Some(0);
    let mut i = l;
    while i != 0 {
        if let Option::None = result {
            break;
        }

        i -= 1;

        // ByteArray.at returns the ASCII representation of the character,
        // so we need to subtract the position of the decimal '0' in ASCII
        // (ASCII 48 == 0)
        let digit: u8 = s.at(i).into().unwrap() - 48;

        result = match u32_overflowing_add(result.unwrap(), pow(digit, l)) {
            Result::Ok(val) => Option::Some(val),
            Result::Err(_) => Option::None,
        };
    };

    result == Option::Some(num)
}

fn pow(base: u8, exponent: u32) -> u32 {
    let mut result: u32 = 1;
    let mut i = exponent;
    while i != 0 {
        result *= base.into(); // cast u8 into u32
        i -= 1;
    };
    result
}

#[cfg(test)]
mod tests;
