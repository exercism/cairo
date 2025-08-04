use core::num::traits::Pow;

pub fn is_armstrong_number(mut num: u128) -> bool {
    let mut original_num = num;
    let digits = count_digits(num);
    loop {
        if num == 0 {
            break original_num == 0;
        }

        let lastDigit = num % 10;
        let sum = lastDigit.pow(digits);
        num = num / 10;
        if sum > original_num {
            break false;
        }
        original_num = original_num - sum;
    }
}

fn count_digits(mut num: u128) -> u32 {
    let mut res = 0;
    while num != 0 {
        num = num / 10;
        res += 1;
    }
    res
}
