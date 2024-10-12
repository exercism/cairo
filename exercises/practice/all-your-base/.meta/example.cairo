#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn rebase(digits: Array<u32>, inputBase: u32, outputBase: u32) -> Result<Array<u32>, Error> {
    if inputBase < 2 {
        return Result::Err(Error::InvalidInputBase);
    }
    if outputBase < 2 {
        return Result::Err(Error::InvalidOutputBase);
    }
    if digits.is_empty() {
        return Result::Ok(array![0]);
    }

    let mut response: u32 = 0;
    let mut i: u32 = 0;
    while i < digits.len() {
        if *digits.at(i) >= inputBase {
            response = i;
            break;
        }
        i += 1;
    };

    if response > 0 || i == 0 {
        let x = *digits.at(i);
        return Result::Err(Error::InvalidDigit(x));
    }

    let base_10_digits = convert_outputBase_10(digits, inputBase);

    let result = convert_inputBase_10(base_10_digits, outputBase);

    Result::Ok(result)
}

fn convert_outputBase_10(digits: Array<u32>, inputBase: u32) -> u32 {
    let mut sum = 0;
    let mut i = 0;
    let len = digits.len();
    while i < len {
        let digit = digits[i];
        let exp = len - 1 - i;
        let pow = pow(inputBase, exp);
        sum += *digit * pow;
        i += 1;
    };

    sum
}

fn convert_inputBase_10(mut digits: u32, outputBase: u32) -> Array<u32> {
    let mut result: Array<u32> = ArrayTrait::new();
    if digits == 0 {
        result.append(0);
        return result;
    }

    while digits > 0 {
        let remainder = digits % outputBase;
        digits /= outputBase;
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

fn pow(base: u32, mut power: u32) -> u32 {
    if base == 0 {
        return base;
    }
    let base: u256 = base.into();
    let mut result = 1_u256;
    while power != 0 {
        result *= base;
        power -= 1;
    };

    result.try_into().expect('too large to fit output type')
}
