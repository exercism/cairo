use core::nullable::{match_nullable, FromNullableResult};
use core::dict::{Felt252Dict, Felt252DictEntryTrait};

pub fn solve(puzzle: ByteArray) -> Option<Array<(u8, u8)>> {
    let (mut words_as_numbers, mut letters) = parse_words(puzzle).ok()?;

    if !init_permutation(ref words_as_numbers, ref letters) {
        return Option::None;
    }

    find_solution(ref words_as_numbers, ref letters)
}

fn parse_words(puzzle: ByteArray) -> Result<(WordsAsNumbers, Vec), felt252> {
    let mut words_as_numbers: WordsAsNumbers = Default::default();
    let mut letters: Vec = Default::default();

    let mut max_word_len = 0_usize;

    let mut chars: Array<u8> = array![];
    let mut i = 0_usize;
    while i < puzzle.len() {
        let ch = puzzle[i];
        if ch == '=' || ch == '+' {
            let current_word_len = chars.len();
            let letter_key = *chars[0];
            let digit_index: u8 = (current_word_len - 1).try_into().unwrap();
            letters
                .append(
                    letter_key,
                    LetterPos { word_index: words_as_numbers.len, digit_index },
                    min: Option::Some(1),
                );
            for j in 1
                ..current_word_len {
                    let letter_key = *chars[j];
                    let digit_index: u8 = (current_word_len - 1 - j).try_into().unwrap();
                    letters
                        .append(
                            letter_key,
                            LetterPos { word_index: words_as_numbers.len, digit_index },
                            min: Option::None,
                        );
                };
            words_as_numbers.append(0);
            if current_word_len > max_word_len {
                max_word_len = current_word_len;
            }
            chars = array![];
            // jump over the next space char
            i += 2;
        } else if is_whitespace(ch) {
            i += 1;
        } else {
            chars.append(ch);
            i += 1;
        }
    };

    let result_len = chars.len();
    if result_len < max_word_len {
        return Result::Err('result smaller than sum');
    }

    let letter_key = *chars[0];
    let digit_index: u8 = (result_len - 1).try_into().unwrap();
    letters
        .append(
            letter_key,
            LetterPos { word_index: words_as_numbers.len, digit_index },
            min: Option::Some(1),
        );
    for j in 1
        ..result_len {
            let letter_key = *chars[j];
            let digit_index: u8 = (result_len - 1 - j).try_into().unwrap();
            letters
                .append(
                    letter_key,
                    LetterPos { word_index: words_as_numbers.len, digit_index },
                    min: Option::None,
                );
        };
    words_as_numbers.append(0);

    Result::Ok((words_as_numbers, letters))
}

fn init_permutation(ref words_as_numbers: WordsAsNumbers, ref letters: Vec) -> bool {
    let mut result = true;
    for i in 0
        ..letters
            .chars
            .len() {
                let char = *letters.chars[i];
                let mut letter = letters.get(char.into());
                letter.digit = letter.min;
                while letters.contains(letter.digit, i) {
                    letter.digit += 1;
                };
                if letter.digit > 9 {
                    result = false;
                    break;
                }
                letters.set(char.into(), letter);
                for pos in letter
                    .positions {
                        words_as_numbers
                            .replace_digit_at(*pos.word_index, *pos.digit_index, letter.digit);
                    };
            };
    result
}

fn find_solution(
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
                    let ch = *letters.chars[i];
                    result.append((ch, letters.get(ch).digit));
                };

        return Option::Some(result);
    }

    if !update_permutation(ref words_as_numbers, ref letters) {
        return Option::None;
    }

    find_solution(ref words_as_numbers, ref letters)
}

fn update_permutation(ref words_as_numbers: WordsAsNumbers, ref letters: Vec) -> bool {
    let mut letters = letters.next_permutation();
    if letters.is_empty() {
        return false;
    }
    for letter in letters {
        for pos in letter
            .positions {
                words_as_numbers.replace_digit_at(*pos.word_index, *pos.digit_index, letter.digit);
            };
    };
    true
}

#[derive(Destruct, Default)]
struct Vec {
    dict: Felt252Dict<Nullable<Letter>>,
    chars: Array<u8>,
}

#[derive(Drop, Copy, Debug, PartialEq)]
struct Letter {
    char: u8,
    positions: Span<LetterPos>,
    digit: u8,
    min: u8,
    max: u8,
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
        let mut letter = letter
            .deref_or(
                Letter { char: letter_key, digit: 0, positions: array![].span(), min: 0, max: 9 }
            );
        letter
    }

    fn append(ref self: Vec, letter_key: u8, value: LetterPos, min: Option<u8>) {
        let (entry, letter) = self.dict.entry(letter_key.into());
        let mut letter = match match_nullable(letter) {
            FromNullableResult::NotNull(value) => value.unbox(),
            FromNullableResult::Null => {
                self.chars.append(letter_key);
                Letter { char: letter_key, digit: 0, positions: array![].span(), min: 0, max: 9 }
            }
        };
        let mut new_positions = array![];
        new_positions.append_span(letter.positions);
        new_positions.append(value);
        letter.positions = new_positions.span();
        if let Option::Some(min) = min {
            if (letter.min < min) {
                letter.min = min;
            }
        }
        self.dict = entry.finalize(NullableTrait::new(letter));
    }

    // Helper function to check if a value is already present in the array up to a given index.
    fn contains(ref self: Vec, digit: u8, up_to: usize) -> bool {
        let mut chars = self.chars.span().slice(0, up_to);
        loop {
            if let Option::Some(char) = chars.pop_front() {
                if self.get(*char.into()).digit == digit {
                    break true;
                }
            } else {
                break false;
            }
        }
    }

    // Function to generate the next lexicographical non-repeating permutation
    fn next_permutation(ref self: Vec) -> Array<Letter> {
        let mut updated_letters = array![];

        let n = self.chars.len();

        let mut valid_perm = false;

        // Step 1: Start from the rightmost element and try to increment it.
        let mut i = n;
        while i != 0 {
            i -= 1;
            let char = *self.chars[i];

            // Try to increment the current element
            let mut letter = self.get(char.into());
            letter.digit += 1;

            // Step 2: Ensure the new value is not already present in the array
            while letter.digit <= 9 && self.contains(letter.digit, i) {
                letter.digit += 1;
            };

            if letter.digit <= 9 {
                // Step 3: Set the incremented value at position `i`
                self.set(char, letter);
                updated_letters.append(letter);
                valid_perm = true;
                break;
            }
            // If the incremented value exceeds `9`, try the next position to the left
        };

        if !valid_perm {
            return updated_letters;
        }

        // Step 4: Reset all elements to the right of position `i` to the smallest non-repeating
        // values
        for j in (i + 1)
            ..n {
                let char = *self.chars[j];
                let mut letter = self.get(char.into());
                letter.digit = letter.min;
                while self.contains(letter.digit, j) {
                    letter.digit += 1;
                };
                self.set(char.into(), letter);
                if letter.digit > 9 {
                    valid_perm = false;
                    break;
                } else {
                    updated_letters.append(letter);
                }
            };

        if valid_perm {
            updated_letters
        } else {
            self.next_permutation()
        }
    }

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

    fn replace_digit_at(ref self: WordsAsNumbers, index: usize, at_digit: u8, new_digit: u8) {
        assert!(
            self.len > index,
            "{}",
            format!("unexpected word index: {index} and length is {}", self.len)
        );

        let mut number = self.get(index.into());
        number.replace_digit_at(at_digit, new_digit);
        self.dict.insert(index.into(), number);
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
    fn replace_digit_at(ref self: T, at: u8, new_digit: u8) {
        let mut ten_pow = 1_u128;
        for _ in 0..at {
            ten_pow *= 10;
        };

        if self.into() < ten_pow {
            self = (ten_pow * new_digit.into() + self.into()).try_into().unwrap();
        } else {
            let rest = self.into() % ten_pow;
            let prefix = self.into() / ten_pow / 10_u8.into();
            self = ((prefix * 10 + new_digit.into()) * ten_pow + rest).try_into().unwrap();
        }
    }
}

fn is_whitespace(chr: u8) -> bool {
    chr == ' ' || chr == '\t' || chr == '\n' || chr == '\r'
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
                    number.replace_digit_at(data.at, data.new_digit);
                    assert_eq!(number, data.expected, "failed for {data:?}");
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
            expected_wan.append(0);
            expected_wan.append(0);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['I', 'B', 'L'];
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 0,
                        min: 1,
                        max: 9,
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
                        char: 'B',
                        digit: 0,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 0,
                        min: 0,
                        max: 9,
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
            expected_wan.append(0);
            expected_wan.append(0);
            expected_wan.append(0);
            expected_wan.append(0);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['H', 'E', 'S', 'T', 'L', 'I', 'G'];
            expected_vec
                .set(
                    'H',
                    Letter {
                        char: 'H',
                        digit: 0,
                        min: 1,
                        max: 9,
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
                        char: 'E',
                        digit: 0,
                        min: 0,
                        max: 9,
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
                        char: 'S',
                        digit: 0,
                        min: 1,
                        max: 9,
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
                        char: 'T',
                        digit: 0,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 4 },].span()
                    }
                );
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 3 },].span()
                    }
                );
            expected_vec
                .set(
                    'G',
                    Letter {
                        char: 'G',
                        digit: 0,
                        min: 0,
                        max: 9,
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

    mod init_permutation {
        use super::super::{
            WordsAsNumbers, WordsAsNumbersTrait, Vec, Letter, LetterPos, VecTrait, init_permutation
        };

        #[test]
        fn puzzle_with_three_letters() {
            // let puzzle = "I + BB == ILL";
            let mut expected_wan: WordsAsNumbers = Default::default();
            expected_wan.append(1);
            expected_wan.append(22);
            expected_wan.append(100);

            let mut actual_wan: WordsAsNumbers = Default::default();
            actual_wan.append(0);
            actual_wan.append(0);
            actual_wan.append(0);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['I', 'B', 'L'];
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 1,
                        min: 1,
                        max: 9,
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
                        char: 'B',
                        digit: 2,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let mut actual_vec: Vec = Default::default();
            actual_vec.chars = array!['I', 'B', 'L'];
            actual_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 2 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'B',
                    Letter {
                        char: 'B',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'L',
                    Letter {
                        char: 'L',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            assert!(init_permutation(ref actual_wan, ref actual_vec));

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
                    };
        }

        #[test]
        fn puzzle_with_seven_letters() {
            // let puzzle = "HE + SEES + THE == LIGHT";
            let mut expected_wan: WordsAsNumbers = Default::default();
            expected_wan.append(10);
            expected_wan.append(2002);
            expected_wan.append(310);
            expected_wan.append(45613);

            let mut actual_wan: WordsAsNumbers = Default::default();
            actual_wan.append(0);
            actual_wan.append(0);
            actual_wan.append(0);
            actual_wan.append(0);

            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['H', 'E', 'S', 'T', 'L', 'I', 'G'];
            expected_vec
                .set(
                    'H',
                    Letter {
                        char: 'H',
                        digit: 1,
                        min: 1,
                        max: 9,
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
                        char: 'E',
                        digit: 0,
                        min: 0,
                        max: 9,
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
                        char: 'S',
                        digit: 2,
                        min: 1,
                        max: 9,
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
                        char: 'T',
                        digit: 3,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 4,
                        min: 1,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 4 },].span()
                    }
                );
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 5,
                        min: 0,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 3 },].span()
                    }
                );
            expected_vec
                .set(
                    'G',
                    Letter {
                        char: 'G',
                        digit: 6,
                        min: 0,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 2 },].span()
                    }
                );

            let mut actual_vec: Vec = Default::default();
            actual_vec.chars = array!['H', 'E', 'S', 'T', 'L', 'I', 'G'];
            actual_vec
                .set(
                    'H',
                    Letter {
                        char: 'H',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 1 },
                            LetterPos { word_index: 2, digit_index: 1 },
                            LetterPos { word_index: 3, digit_index: 1 },
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'E',
                    Letter {
                        char: 'E',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 },
                            LetterPos { word_index: 1, digit_index: 2 },
                            LetterPos { word_index: 2, digit_index: 0 },
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'S',
                    Letter {
                        char: 'S',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 3 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'T',
                    Letter {
                        char: 'T',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 2 },
                            LetterPos { word_index: 3, digit_index: 0 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'L',
                    Letter {
                        char: 'L',
                        digit: 0,
                        min: 1,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 4 },].span()
                    }
                );
            actual_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 3 },].span()
                    }
                );
            actual_vec
                .set(
                    'G',
                    Letter {
                        char: 'G',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![LetterPos { word_index: 3, digit_index: 2 },].span()
                    }
                );

            assert!(init_permutation(ref actual_wan, ref actual_vec));

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
                    };
        }
    }

    mod next_permutation {
        use super::super::{Vec, Letter, LetterPos, VecTrait};

        #[test]
        fn just_last_digit_changed() {
            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['I', 'B', 'L'];
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 1,
                        min: 1,
                        max: 9,
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
                        char: 'B',
                        digit: 2,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 3,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let mut actual_vec: Vec = Default::default();
            actual_vec.chars = array!['I', 'B', 'L'];
            actual_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 1,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 2 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'B',
                    Letter {
                        char: 'B',
                        digit: 2,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'L',
                    Letter {
                        char: 'L',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let letters = actual_vec.next_permutation();
            assert_eq!(letters.len(), 1);
            assert_eq!(
                letters[0],
                @Letter {
                    char: 'L',
                    digit: 3,
                    min: 0,
                    max: 9,
                    positions: array![
                        LetterPos { word_index: 2, digit_index: 0 },
                        LetterPos { word_index: 2, digit_index: 1 }
                    ]
                        .span()
                }
            );

            for i in 0
                ..expected_vec
                    .chars
                    .len() {
                        assert_eq!(
                            expected_vec.get(i.try_into().unwrap()),
                            actual_vec.get(i.try_into().unwrap())
                        );
                    };
        }

        #[test]
        fn all_digits_changed() {
            let mut expected_vec: Vec = Default::default();
            expected_vec.chars = array!['I', 'B', 'L'];
            expected_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 2,
                        min: 1,
                        max: 9,
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
                        char: 'B',
                        digit: 1,
                        min: 1,
                        max: 9,
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
                        char: 'L',
                        digit: 0,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let mut actual_vec: Vec = Default::default();
            actual_vec.chars = array!['I', 'B', 'L'];
            actual_vec
                .set(
                    'I',
                    Letter {
                        char: 'I',
                        digit: 1,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 0, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 2 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'B',
                    Letter {
                        char: 'B',
                        digit: 9,
                        min: 1,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 1, digit_index: 0 },
                            LetterPos { word_index: 1, digit_index: 1 }
                        ]
                            .span()
                    }
                );
            actual_vec
                .set(
                    'L',
                    Letter {
                        char: 'L',
                        digit: 8,
                        min: 0,
                        max: 9,
                        positions: array![
                            LetterPos { word_index: 2, digit_index: 0 },
                            LetterPos { word_index: 2, digit_index: 1 }
                        ]
                            .span()
                    }
                );

            let letters = actual_vec.next_permutation();
            assert_eq!(letters.len(), 3);
            assert_eq!(
                letters[0],
                @Letter {
                    char: 'I',
                    digit: 2,
                    min: 1,
                    max: 9,
                    positions: array![
                        LetterPos { word_index: 0, digit_index: 0 },
                        LetterPos { word_index: 2, digit_index: 2 }
                    ]
                        .span()
                }
            );
            assert_eq!(
                letters[1],
                @Letter {
                    char: 'B',
                    digit: 1,
                    min: 1,
                    max: 9,
                    positions: array![
                        LetterPos { word_index: 1, digit_index: 0 },
                        LetterPos { word_index: 1, digit_index: 1 }
                    ]
                        .span()
                }
            );
            assert_eq!(
                letters[2],
                @Letter {
                    char: 'L',
                    digit: 0,
                    min: 0,
                    max: 9,
                    positions: array![
                        LetterPos { word_index: 2, digit_index: 0 },
                        LetterPos { word_index: 2, digit_index: 1 }
                    ]
                        .span()
                }
            );

            for i in 0
                ..expected_vec
                    .chars
                    .len() {
                        assert_eq!(
                            expected_vec.get(i.try_into().unwrap()),
                            actual_vec.get(i.try_into().unwrap())
                        );
                    };
        }
    }
}
