use core::num::traits::Pow;

#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn rebase(digits: Array<u32>, input_base: u32, output_base: u32) -> Result<Array<u32>, Error> {
    if input_base < 2 {
        return Result::Err(Error::InvalidInputBase);
    }
    if output_base < 2 {
        return Result::Err(Error::InvalidOutputBase);
    }
    if digits.is_empty() {
        return Result::Ok(array![0]);
    }

    let mut response: u32 = 0;
    let mut i: u32 = 0;
    while i < digits.len() {
        if *digits.at(i) >= input_base {
            response = i;
            break;
        }
        i += 1;
    };

    if response > 0 || i == 0 {
        let x = *digits.at(i);
        return Result::Err(Error::InvalidDigit(x));
    }

    let base_10_digits = convert_to_base_10(digits, input_base);

    let result = convert_from_base_10(base_10_digits, output_base);

    Result::Ok(result)
}

fn convert_to_base_10(digits: Array<u32>, input_base: u32) -> u32 {
    let mut sum = 0;
    let mut i = 0;
    let len = digits.len();
    while i < len {
        let digit = digits[i];
        let exp = len - 1 - i;
        let pow = input_base.pow(exp);
        sum += *digit * pow;
        i += 1;
    };

    sum
}

fn convert_from_base_10(mut digits: u32, output_base: u32) -> Array<u32> {
    let mut result: Array<u32> = ArrayTrait::new();
    if digits == 0 {
        result.append(0);
        return result;
    }

    while digits > 0 {
        let remainder = digits % output_base;
        digits /= output_base;
        result.append(remainder);
    };

    reverse_array(result)
}

fn reverse_array(arr: Array<u32>) -> Array<u32> {
    let mut reversed: Array<u32> = ArrayTrait::new();

    let mut i = arr.len();
    while i > 0 {
        i -= 1;
        reversed.append(*arr[i]);
    };

    reversed
}
