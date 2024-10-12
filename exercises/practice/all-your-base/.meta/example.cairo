#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}

pub fn convert(number: Array<u32>, from_base: u32, to_base: u32) -> Result<Array<u32>, Error> {
    if from_base < 2 {
        return Result::Err(Error::InvalidInputBase);
    }
    if to_base < 2 {
        return Result::Err(Error::InvalidOutputBase);
    }
    if number.is_empty() {
        return Result::Ok(array![0]);
    }

    let mut response: u32 = 0;
    let mut i: u32 = 0;
    while i < number.len() {
        if *number.at(i) >= from_base {
            response = i;
            break;
        }
        i += 1;
    };

    if response > 0 || i == 0 {
        let x = *number.at(i);
        return Result::Err(Error::InvalidDigit(x));
    }

    let base_10_number = convert_to_base_10(number, from_base);

    let result = convert_from_base_10(base_10_number, to_base);

    Result::Ok(result)
}

fn convert_to_base_10(number: Array<u32>, from_base: u32) -> u32 {
    let mut sum = 0;
    let mut i = 0;
    let len = number.len();
    while i < len {
        let digit = number[i];
        let exp = len - 1 - i;
        let pow = pow(from_base, exp);
        sum += *digit * pow;
        i += 1;
    };

    sum
}

fn convert_from_base_10(mut number: u32, to_base: u32) -> Array<u32> {
    let mut result: Array<u32> = ArrayTrait::new();
    if number == 0 {
        result.append(0);
        return result;
    }

    while number > 0 {
        let remainder = number % to_base;
        number /= to_base;
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
