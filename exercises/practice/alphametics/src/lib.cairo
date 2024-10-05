pub fn solve(puzzle: ByteArray) -> Option<Array<(u8, u8)>> {
    panic!("implement `solve`")
}

#[generate_trait]
impl ReplaceDigitImpl<
    T,
    +Into<u8, T>,
    +Into<T, u256>,
    +TryInto<u256, T>,
    +PartialEq<T>,
    +Copy<T>,
    +Drop<T>,
    +Default<T>,
    +core::fmt::Display<T>,
> of ReplaceDigitTrait<T> {
    fn replace_digit_at(ref self: T, at: u8, new_digit: u8) -> Result<T, ByteArray> {
        if self == Default::default() && at > 0 {
            return Result::Err(
                format!("invalid for number: {self}, at: {at}, new_digit: {new_digit}")
            );
        }

        if self == Default::default() {
            self = new_digit.into();
            return Result::Ok(self);
        }

        let mut ten_pow = 1_u256;
        for _ in 0..at {
            ten_pow *= 10;
        };

        if self.into() < ten_pow {
            return Result::Err(
                format!("invalid for number: {self}, at: {at}, new_digit: {new_digit}")
            );
        }

        let rest = self.into() % ten_pow;
        let prefix = self.into() / ten_pow / 10_u8.into();
        self = ((prefix * 10 + new_digit.into()) * ten_pow + rest).try_into().unwrap();

        Result::Ok(self)
    }
}

#[test]
mod tests {
    mod replace_digit_at {
        use core::iter::IntoIterator;
        use super::super::ReplaceDigitTrait;

        #[derive(Drop, Debug)]
        struct TestData {
            number: u256,
            at: u8,
            new_digit: u8,
            expected: u256,
        }

        #[test]
        fn succeeding_tests() {
            let test_cases = array![
                TestData { number: 0, at: 0, new_digit: 4, expected: 4, },
                TestData { number: 3, at: 0, new_digit: 3, expected: 3, },
                TestData { number: 123, at: 1, new_digit: 4, expected: 143, },
                TestData { number: 10000, at: 3, new_digit: 6, expected: 16000, },
                TestData { number: 1000, at: 3, new_digit: 4, expected: 4000, },
                TestData { number: 123456789, at: 7, new_digit: 9, expected: 193456789, },
            ];
            for data in test_cases
                .into_iter() {
                    let mut number = data.number;
                    let result = number.replace_digit_at(data.at, data.new_digit);
                    assert!(result.is_ok(), "failed for {data:?}");
                    assert_eq!(result.unwrap(), data.expected, "failed for {data:?}");
                };
        }

        #[test]
        fn failing_tests() {
            let test_cases = array![
                TestData { number: 0, at: 1, new_digit: 4, expected: 0 },
                TestData { number: 3, at: 1, new_digit: 3, expected: 0, },
                TestData { number: 123, at: 3, new_digit: 4, expected: 0, },
                TestData { number: 10000, at: 10, new_digit: 6, expected: 0, },
                TestData { number: 123456789, at: 9, new_digit: 9, expected: 0, },
            ];
            for data in test_cases
                .into_iter() {
                    let mut number = data.number;
                    let result = number.replace_digit_at(data.at, data.new_digit);
                    assert!(result.is_err(), "unexpectedly succeeded for: {data:?}");
                };
        }
    }
}
