#[derive(Drop, PartialEq)]
enum Operator {
    Plus,
    Minus,
    Multiply,
    Divide,
    Invalid,
}

pub fn answer(word: ByteArray) -> (i32, bool) {
    let words: Array<ByteArray> = split_string_into_words(word);
    if words.len() < 3 {
        return (0, false);
    }

    if words[0] != @"What" || words[1] != @"is" {
        return (0, false);
    }

    let mut result: i32 = match words.get(2) {
        Option::Some(s) => {
            match convert_ByteArray_to_int(s.unbox()) {
                Option::Some(s) => s,
                Option::None => { return (0, false); }
            }
        },
        Option::None => { return (0, false); },
    };

    let mut i = 3;
    while i < words.len() {
        let op = parse_operator(words.at(i));
        i += 1;

        if op == Operator::Multiply || op == Operator::Divide {
            if i >= words.len() || words[i] != @"by" {
                result = 0;
                break;
            }
            i += 1;
        }

        let num: i32 = match words.get(i) {
            Option::Some(s) => {
                match convert_ByteArray_to_int(s.unbox()) {
                    Option::Some(s) => s,
                    Option::None => {
                        result = 0;
                        break;
                    }
                }
            },
            Option::None => {
                result = 0;
                break;
            },
        };

        result = match op {
            Operator::Plus => result + num,
            Operator::Minus => result - num,
            Operator::Multiply => result * num,
            Operator::Divide => {
                if num == 0 {
                    result = 0;
                    break;
                }
                result / num
            },
            Operator::Invalid => {
                result = 0;
                break;
            },
        };

        i += 1;
    };

    if (result == 0) {
        (result, false)
    } else {
        (result, true)
    }
}


fn split_string_into_words(long_string: ByteArray) -> Array<ByteArray> {
    let mut words: Array<ByteArray> = ArrayTrait::new();
    let mut current_word = "";

    let mut i = 0;
    while i < long_string.len() {
        let byte = long_string[i];
        if byte == 32 {
            if current_word.len() > 0 {
                words.append(current_word);
                current_word = "";
            }
        } else if (byte == 63) {
            break;
        } else {
            current_word.append_byte(byte);
        }
        i += 1;
    };

    if current_word.len() > 0 {
        words.append(current_word);
    }

    words
}


fn convert_ByteArray_to_int(num: @ByteArray) -> Option<i32> {
    let mut result: Option<i32> = Option::Some(0);
    let mut size = num.len();
    let mut i = 0;
    let mut base = 0;

    let mut isSigned = false;
    if num.at(i).unwrap() == 45 {
        isSigned = true;
        size -= 1;
    }
    let num: ByteArray = num.rev();

    while i < size {
        let mut args = "";
        args.append_byte(num.at(i).unwrap());
        let re = get_number(args);
        match re {
            Option::Some(v) => { base += v * pow(i); },
            Option::None => {
                result = Option::None;
                break;
            }
        }
        i += 1;
    };

    if result != Option::None {
        if (isSigned) {
            base *= -1;
        }
        return Option::Some(base);
    } else {
        return result;
    }
}


fn pow(mut power: u32) -> i32 {
    let base: i32 = 10;
    let mut result = 1_i32;
    while power != 0 {
        result *= base;
        power -= 1;
    };

    result.try_into().expect('too large to fit output type')
}

fn parse_operator(word: @ByteArray) -> Operator {
    if (word == @"plus") {
        return Operator::Plus;
    } else if (word == @"minus") {
        return Operator::Minus;
    } else if (word == @"multiplied") {
        return Operator::Multiply;
    } else if (word == @"divided") {
        return Operator::Divide;
    } else {
        return Operator::Invalid;
    }
}


fn get_number(c: ByteArray) -> Option<i32> {
    if c == "1" {
        Option::Some(1)
    } else if c == "2" {
        Option::Some(2)
    } else if c == "3" {
        Option::Some(3)
    } else if c == "4" {
        Option::Some(4)
    } else if c == "5" {
        Option::Some(5)
    } else if c == "6" {
        Option::Some(6)
    } else if c == "7" {
        Option::Some(7)
    } else if c == "8" {
        Option::Some(8)
    } else if c == "9" {
        Option::Some(9)
    } else if c == "0" {
        Option::Some(0)
    } else {
        Option::None
    }
}
