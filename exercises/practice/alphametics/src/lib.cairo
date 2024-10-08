use core::nullable::{match_nullable, FromNullableResult};
use core::dict::{Felt252Dict, Felt252DictEntryTrait};

fn parse_words(puzzle: ByteArray) -> Result<(WordsAsNumbers, Vec), felt252> {
    let mut words_as_numbers: WordsAsNumbers = Default::default();
    let mut letters: Vec = Default::default();

    let mut max_word_len = 0_u8;
    let mut current_word_len = 0_u8;

    let mut word_as_number = 0_u128;
    let mut word_index = 0_usize;
    let mut digit_index = 0_u8;
    let mut i = 0_usize;
    while i < puzzle.len() {
        let ch = puzzle[i];
        if ch == '=' {
            word_index += 1;
            // jump over '= ' to get to next char
            i += 3;
        } else if ch == '+' {
            word_index += 1;
            // jump over the next space char
            i += 2;
        } else if ch == ' ' {
            // word_as_number is 1 digit longer, so we truncate
            words_as_numbers.append(word_as_number / 10);
            word_as_number = 0;
            digit_index = 0;
            if current_word_len > max_word_len {
                max_word_len = current_word_len;
            }
            current_word_len = 0;
            i += 1;
        } else {
            let digit = letters.append(ch, LetterPos { word_index, digit_index });
            word_as_number = (word_as_number + digit.into()) * 10;
            digit_index += 1;
            current_word_len += 1;
            i += 1;
        }
    };

    let result_len = current_word_len;
    if result_len < max_word_len {
        return Result::Err('result smaller than sum');
    } else if result_len - 1 > max_word_len {
        return Result::Err('sum smaller than result');
    }

    // word_as_number has a trailing zero which we truncate
    words_as_numbers.append(word_as_number / 10);

    Result::Ok((words_as_numbers, letters))
}

fn check_solution(
    ref words_as_numbers: WordsAsNumbers, ref letters: Vec
) -> Option<Array<(u8, u8)>> {
    let result_index = words_as_numbers.len - 1;
    let mut sum = 0_u128;
    for i in 0..result_index {
        sum += words_as_numbers.get(i.into());
    };
    if sum == words_as_numbers.get(result_index.into()) {
        let mut result = array![];
        for i in 0
            ..letters
                .chars
                .len() {
                    result.append((*letters.chars[i], letters.get(i.try_into().unwrap()).digit));
                };

        return Option::Some(result);
    }

    if is_last_permutation(ref letters) {
        return Option::None;
    }

    check_solution(ref words_as_numbers, ref letters)
}

fn is_last_permutation(ref letters: Vec) -> bool {
    let mut last = true;
    let mut expected_digit = 9;
    for i in 0
        ..letters
            .chars
            .len() {
                if letters.get(i.try_into().unwrap()).digit == expected_digit {
                    expected_digit -= 1;
                } else {
                    last = false;
                    break;
                }
            };
    last
}

pub fn solve(puzzle: ByteArray) -> Option<Array<(u8, u8)>> {
    let (mut words_as_numbers, mut letters) = parse_words(puzzle).ok()?;
    check_solution(ref words_as_numbers, ref letters)
}

#[derive(Destruct, Default)]
struct Vec {
    dict: Felt252Dict<Nullable<Letter>>,
    chars: Array<u8>,
}

#[derive(Drop, Copy, Debug, PartialEq)]
struct Letter {
    positions: Span<LetterPos>,
    digit: u8
}

#[derive(Drop, Clone, Debug, PartialEq)]
struct LetterPos {
    word_index: usize,
    digit_index: u8
}

#[generate_trait]
impl VecImpl of VecTrait {
    fn get(ref self: Vec, letter_key: u8) -> Letter {
        let letter = self.dict.get(letter_key.into());
        let mut letter = letter.deref_or(Letter { digit: 0, positions: array![].span() });
        letter
    }

    fn append(ref self: Vec, letter_key: u8, value: LetterPos) -> u8 {
        let (entry, letter) = self.dict.entry(letter_key.into());
        let mut letter = match match_nullable(letter) {
            FromNullableResult::NotNull(value) => value.unbox(),
            FromNullableResult::Null => {
                self.chars.append(letter_key);
                Letter {
                    digit: self.chars.len().try_into().unwrap() - 1, positions: array![].span()
                }
            }
        };
        let mut new_positions = array![];
        new_positions.append_span(letter.positions);
        new_positions.append(value);
        letter.positions = new_positions.span();
        let digit = letter.digit;
        self.dict = entry.finalize(NullableTrait::new(letter));
        digit
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

    fn append(ref self: WordsAsNumbers, number: u128) {
        self.dict.insert(self.len.into(), number);
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

        let mut number = self.get(index.into());
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
        let mut ten_pow = 1_u128;
        for _ in 0..at {
            ten_pow *= 10;
        };

        if self.into() < ten_pow {
            return Result::Ok((ten_pow * new_digit.into() + self.into()).try_into().unwrap());
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
                TestData { number: 0, at: 1, new_digit: 4, expected: 40 },
                TestData { number: 3, at: 1, new_digit: 3, expected: 33, },
                TestData { number: 123, at: 3, new_digit: 4, expected: 4123, },
                TestData { number: 10000, at: 10, new_digit: 6, expected: 60000010000, },
                TestData { number: 123456789, at: 9, new_digit: 9, expected: 9123456789, },
            ];
            for data in test_cases
                .into_iter() {
                    let mut number = data.number;
                    let result = number.replace_digit_at(data.at, data.new_digit);
                    assert!(result.is_ok(), "failed for {data:?}");
                    assert_eq!(result.unwrap(), data.expected, "failed for {data:?}");
                };
        }
    }

    mod parse_words {
        use super::super::WordsAsNumbersTrait;
        use super::super::{parse_words, WordsAsNumbers, Vec, Letter, LetterPos, VecTrait};

        #[test]
        fn puzzle_with_three_letters() {
            let puzzle = "I + BB == ILL";
            let mut expected_wan: WordsAsNumbers = Default::default();
            expected_wan.append(0);
            expected_wan.append(11);
            expected_wan.append(22);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['I', 'B', 'L'];
            expected_vec
                .set(
                    'I',
                    Letter {
                        digit: 0,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 2 }
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'B',
                    Letter {
                        digit: 1,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 }
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'L',
                    Letter {
                        digit: 2,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let (mut actual_wan, mut actual_vec) = parse_words(puzzle).unwrap();

            assert_eq!(actual_wan.len, expected_wan.len);
            for i in 0
                ..expected_wan
                    .len {
                        assert_eq!(expected_wan.get(i.into()), actual_wan.get(i.into()));
                    };

            for i in 0
                ..expected_vec
                    .chars
                    .len() {
                        assert_eq!(
                            expected_vec.get(i.try_into().unwrap()),
                            actual_vec.get(i.try_into().unwrap())
                        );
                        assert_eq!(expected_vec.chars[i], actual_vec.chars[i]);
                    };
        }

        #[test]
        fn leading_zero_solution_is_invalid() {
            let puzzle = "ACA + DD == BD";
            assert!(parse_words(puzzle).ok().is_none());
        }

        #[test]
        fn puzzle_with_seven_letters() {
            let puzzle = "HE + SEES + THE == LIGHT";
            let mut expected_wan: WordsAsNumbers = Default::default();
            expected_wan.append(1);
            expected_wan.append(2112);
            expected_wan.append(301);
            expected_wan.append(45603);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['H', 'E', 'S', 'T', 'L', 'I', 'G'];
            expected_vec
                .set(
                    'H',
                    Letter {
                        digit: 0,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 1 },
                            LetterPos { word_index: 2, digit_index: 1 },
                            LetterPos { word_index: 3, digit_index: 1 },
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'E',
                    Letter {
                        digit: 1,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 },
                            LetterPos { word_index: 1, digit_index: 2 },
                            LetterPos { word_index: 2, digit_index: 0 },
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'S',
                    Letter {
                        digit: 2,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 3 }
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'T',
                    Letter {
                        digit: 3,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 2 },
                            LetterPos { word_index: 3, digit_index: 0 }
                        ]
                            .span()
                    }
                );
            expected_vec
                .set(
                    'L',
                    Letter {
                        digit: 4,
                        positions: array![LetterPos { word_index: 3, digit_index: 4 },].span()
                    }
                );
            expected_vec
                .set(
                    'I',
                    Letter {
                        digit: 5,
                        positions: array![LetterPos { word_index: 3, digit_index: 3 },].span()
                    }
                );
            expected_vec
                .set(
                    'G',
                    Letter {
                        digit: 6,
                        positions: array![LetterPos { word_index: 3, digit_index: 2 },].span()
                    }
                );

            let (mut actual_wan, mut actual_vec) = parse_words(puzzle).unwrap();

            assert_eq!(actual_wan.len, expected_wan.len);
            for i in 0
                ..expected_wan
                    .len {
                        assert_eq!(expected_wan.get(i.into()), actual_wan.get(i.into()));
                    };
            for i in 0
                ..expected_vec
                    .chars
                    .len() {
                        assert_eq!(
                            expected_vec.get(i.try_into().unwrap()),
                            actual_vec.get(i.try_into().unwrap())
                        );
                        assert_eq!(expected_vec.chars[i], actual_vec.chars[i]);
                    };
        }
    }
}
