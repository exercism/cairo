fn is_armstrong_number(mut num: u128) -> bool {
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

fn pow<
    T, +SubEq<T>, +Into<u8, T>, +Into<T, u256>, +TryInto<u256, T>, +PartialEq<T>, +Copy<T>, +Drop<T>
>(
    base: T, mut power: T
) -> T {
    if base == 0_u8.into() {
        return base;
    }
    let base: u256 = base.into();
    let mut result: u256 = 1;
    while power != 0_u8.into() {
        result *= base;
        power -= 1_u8.into();
    };
    result.try_into().expect('too large to fit output type')
}

#[cfg(test)]
mod tests;
