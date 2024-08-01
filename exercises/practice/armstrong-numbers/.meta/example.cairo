pub fn is_armstrong_number(mut num: u128) -> bool {
    let mut original_num = num;
    let digits = count_digits(num);
    loop {
        if num == 0 {
            break original_num == 0;
        }

        let lastDigit = num % 10;
        let sum = pow(lastDigit, digits);
        num = num / 10;
        if sum > original_num {
            break false;
        }
        original_num = original_num - sum;
    }
}

fn count_digits(mut num: u128) -> u128 {
    let mut res = 0;
    while num != 0 {
        num = num / 10;
        res += 1;
    };
    res
}

fn pow(base: u128, mut power: u128) -> u128 {
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
