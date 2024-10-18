#[derive(Drop, PartialEq)]
enum Operator {
    Plus,
    Minus,
    Multiply,
    Divide,
    Invalid,
}

pub fn answer(question: ByteArray) -> i32 {
    let words: Array<ByteArray> = split_question_into_words(question);
    assert!(words.len() >= 3, "syntax error");
    assert!(words[0] == @"What" && words[1] == @"is", "unknown operation");

    let mut result = match parse_int(words[2]) {
        Option::Some(s) => s,
        Option::None => panic!("syntax error")
    };

    let mut i = 3;
    while i < words.len() {
        let op = parse_operator(words.at(i));
        i += 1;

        if op == Operator::Multiply || op == Operator::Divide {
            assert!(i < words.len() && words[i] == @"by", "unknown operation");
            i += 1;
        } else if op == Operator::Invalid {
            assert!(parse_int(words.at(i - 1)) != Option::None, "unknown operation");
        }

        let num: i32 = match words.get(i) {
            Option::Some(s) => {
                match parse_int(s.unbox()) {
                    Option::Some(s) => s,
                    Option::None => panic!("syntax error"),
                }
            },
            Option::None => panic!("syntax error"),
        };

        result = match op {
            Operator::Plus => result + num,
            Operator::Minus => result - num,
            Operator::Multiply => result * num,
            Operator::Divide => {
                assert!(num != 0, "unknown operation");
                result / num
            },
            Operator::Invalid => panic!("unknown operation"),
        };

        i += 1;
    };

    result
}


fn split_question_into_words(question: ByteArray) -> Array<ByteArray> {
    let mut words: Array<ByteArray> = ArrayTrait::new();
    let mut current_word = "";

    let mut i = 0;
    while i < question.len() {
        let char = question[i];
        if char == ' ' {
            if current_word.len() > 0 {
                words.append(current_word);
                current_word = "";
            }
        } else if char == '?' {
            if current_word.len() > 0 {
                words.append(current_word);
                current_word = "";
            }
            break;
        } else {
            current_word.append_byte(char);
        }
        i += 1;
    };

    words
}


fn parse_int(num: @ByteArray) -> Option<i32> {
    let mut result: Option<i32> = Option::Some(0);
    let mut size = num.len();
    let mut i = 0;

    let mut is_signed = false;
    if num.at(i).unwrap() == '-' {
        is_signed = true;
        i += 1;
    }

    while i < size {
        let re = char_to_digit(num[i]);
        match re {
            Option::Some(v) => {
                if let Option::Some(max) = result {
                    result = Option::Some(max * 10 + v.into());
                }
            },
            Option::None => {
                result = Option::None;
                break;
            }
        }
        i += 1;
    };

    if let Option::Some(val) = result {
        if (is_signed) {
            result = Option::Some(val * -1)
        }
    }
    result
}

fn parse_operator(word: @ByteArray) -> Operator {
    if (word == @"plus") {
        Operator::Plus
    } else if (word == @"minus") {
        Operator::Minus
    } else if (word == @"multiplied") {
        Operator::Multiply
    } else if (word == @"divided") {
        Operator::Divide
    } else {
        Operator::Invalid
    }
}


// Utility function to convert a char representing a digit into its numerical value (u32 equivalent)
fn char_to_digit(c: u8) -> Option<u8> {
    let zero_ascii = '0';
    let nine_ascii = '9';

    if c >= zero_ascii && c <= nine_ascii {
        Option::Some(c - zero_ascii)
    } else {
        Option::None // Return None for invalid characters
    }
}
