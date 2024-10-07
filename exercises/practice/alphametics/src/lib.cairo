use core::dict::{Felt252Dict, Felt252DictEntryTrait};

fn parse_words(puzzle: ByteArray) -> (WordsAsNumbers, Vec) {
    let mut words_as_numbers: WordsAsNumbers = Default::default();
    let mut letters: Vec = Default::default();

    let mut word_as_number = 1_u128;
    let mut word_index = 0_usize;
    let mut digit_index = 0_u8;
    let mut i = 0_usize;
    while i < puzzle.len() {
        let ch = puzzle[i];
        if ch == '=' {
            word_index += 1;
            i += 3;
        } else if ch == '+' {
            word_index += 1;
            i += 2;
        } else if ch == ' ' {
            // word_as_number is always 1 digit longer then
            words_as_numbers.append(word_as_number / 10);
            word_as_number = 1;
            digit_index = 0;
            i += 1;
        } else {
            letters.append(ch, LetterPos { word_index, digit_index });
            word_as_number *= 10;
            digit_index += 1;
            i += 1;
        }
    };
    words_as_numbers.append(word_as_number);

    (words_as_numbers, letters)
}

pub fn solve(puzzle: ByteArray) -> Option<Array<(u8, u8)>> {
    let (mut _words_as_numbers, mut _letters) = parse_words(puzzle);

    Option::None
}

#[derive(Destruct, Default)]
struct Vec {
    dict: Felt252Dict<Nullable<Letter>>,
    len: u8
}

#[derive(Drop, Debug)]
struct Letter {
    positions: Array<LetterPos>,
    digit: u8
}

#[derive(Drop, Debug)]
struct LetterPos {
    word_index: usize,
    digit_index: u8
}

#[generate_trait]
impl VecImpl of VecTrait {
    fn get_array_entry(ref self: Vec, index: felt252) -> Span<LetterPos> {
        let (entry, letter) = self.dict.entry(index);
        let mut letter = letter.deref_or(Letter { digit: 0, positions: array![] });
        let span = letter.positions.span();
        self.dict = entry.finalize(NullableTrait::new(letter));
        span
    }

    fn append(ref self: Vec, letter_key: u8, value: LetterPos) {
        let (entry, letter) = self.dict.entry(letter_key.into());
        let mut unboxed_val = letter
            .deref_or({
                self.len += 1;
                let digit = self.len;
                Letter { digit, positions: array![] }
            });
        unboxed_val.positions.append(value);
        self.dict = entry.finalize(NullableTrait::new(unboxed_val));
    }

    #[cfg(test)]
    fn set(ref self: Vec, ch: u8, letter: Letter) {
        let (entry, _) = self.dict.entry(ch.into());
        self.dict = entry.finalize(NullableTrait::new(letter));
    }
}

#[derive(Destruct, Default)]
struct WordsAsNumbers {
    dict: Felt252Dict<u128>,
    len: usize
}

#[generate_trait]
impl WordsAsNumbersImpl of WordsAsNumbersTrait {
    fn get(ref self: WordsAsNumbers, key: felt252) -> u128 {
        self.dict.get(key)
    }

    fn append(ref self: WordsAsNumbers, value: u128) {
        self.dict.insert(self.len.into(), value);
        self.len += 1;
    }

    fn replace_digit_at(
        ref self: WordsAsNumbers, index: usize, at_digit: u8, new_digit: u8
    ) -> Result<(), ByteArray> {
        assert!(
            self.len > index,
            "{}",
            format!("unexpected word index: {index} and length is {}", self.len)
        );

        let mut number = self.dict.get(index.into());
        number.replace_digit_at(at_digit, new_digit)?;
        self.dict.insert(index.into(), number);

        Result::Ok(())
    }
}

#[generate_trait]
impl ReplaceDigitImpl<
    T,
    +Into<u8, T>,
    +Into<T, u128>,
    +TryInto<u128, T>,
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

        let mut ten_pow = 1_u128;
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

#[cfg(test)]
mod tests {
    mod replace_digit_at {
        use core::iter::IntoIterator;
        use super::super::ReplaceDigitTrait;

        #[derive(Drop, Debug)]
        struct TestData {
            number: u128,
            at: u8,
            new_digit: u8,
            expected: u128,
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

    mod parse_words {
        use super::super::WordsAsNumbersTrait;
        use super::super::{parse_words, WordsAsNumbers, Vec, Letter, LetterPos, VecTrait};

        #[test]
        fn parses() {
            let puzzle = "I + BB == ILL";
            let mut expected_wan: WordsAsNumbers = Default::default();
            expected_wan.append(1);
            expected_wan.append(10);
            expected_wan.append(100);

            let mut expected_vec: Vec = Default::default();
            expected_vec.len = 3;
            expected_vec
                .set(
                    'I',
                    Letter {
                        digit: 1,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 2 }
                        ]
                    }
                );
            expected_vec
                .set(
                    'B',
                    Letter {
                        digit: 2,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 }
                        ]
                    }
                );
            expected_vec
                .set(
                    'L',
                    Letter {
                        digit: 3,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                    }
                );

            let (mut actual_wan, mut actual_vec) = parse_words(puzzle);

            assert_eq!(actual_wan.len, expected_wan.len);
            assert_eq!(actual_vec.len, expected_vec.len);
        }
    }
}