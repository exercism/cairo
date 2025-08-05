use rpn_calculator::*;

fn calculator_input(s: ByteArray) -> Span<CalculatorInput> {
    let mut calc_input = ArrayTrait::new();

    let components = split_input_into_components(s);
    for c in components {
        let ci = if c == @"+" {
            CalculatorInput::Add
        } else if c == @"-" {
            CalculatorInput::Subtract
        } else if c == @"*" {
            CalculatorInput::Multiply
        } else if c == @"/" {
            CalculatorInput::Divide
        } else {
            CalculatorInput::Value(parse_int(c).unwrap())
        };
        calc_input.append(ci)
    };

    calc_input.span()
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

    for i in i..size {
        match char_to_digit(num[i]) {
            Option::Some(v) => {
                if let Option::Some(num) = result {
                    result = Option::Some(num * 10 + v.into());
                }
            },
            Option::None => {
                result = Option::None;
                break;
            },
        }
    };

    if let Option::Some(val) = result {
        if (is_signed) {
            result = Option::Some(val * -1)
        }
    }
    result
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

fn split_input_into_components(input: ByteArray) -> Span<ByteArray> {
    let mut components: Array<ByteArray> = ArrayTrait::new();
    let mut current_component = "";

    let mut i = 0;
    while i < input.len() {
        let char = input[i];

        if char == ' ' {
            components.append(current_component.clone());
            current_component = "";
        } else {
            current_component.append_byte(char);
        }

        i += 1;
    };

    if current_component.len() > 0 {
        components.append(current_component);
    }

    components.span()
}

#[test]
fn empty_input_returns_none() {
    let input = calculator_input("");
    assert_eq!(evaluate(input), Option::None);
}

#[test]
#[ignore]
fn simple_value() {
    let input = calculator_input("10");
    assert_eq!(evaluate(input), Option::Some(10));
}

#[test]
#[ignore]
fn simple_addition() {
    let input = calculator_input("2 2 +");
    assert_eq!(evaluate(input), Option::Some(4));
}

#[test]
#[ignore]
fn simple_subtraction() {
    let input = calculator_input("7 11 -");
    assert_eq!(evaluate(input), Option::Some(-4));
}

#[test]
#[ignore]
fn simple_multiplication() {
    let input = calculator_input("6 9 *");
    assert_eq!(evaluate(input), Option::Some(54));
}

#[test]
#[ignore]
fn simple_division() {
    let input = calculator_input("57 19 /");
    assert_eq!(evaluate(input), Option::Some(3));
}

#[test]
#[ignore]
fn complex_operation() {
    let input = calculator_input("4 8 + 7 5 - /");
    assert_eq!(evaluate(input), Option::Some(6));
}

#[test]
#[ignore]
fn too_few_operands_returns_none() {
    let input = calculator_input("2 +");
    assert_eq!(evaluate(input), Option::None);
}

#[test]
#[ignore]
fn too_many_operands_returns_none() {
    let input = calculator_input("2 2");
    assert_eq!(evaluate(input), Option::None);
}

#[test]
#[ignore]
fn zero_operands_returns_none() {
    let input = calculator_input("+");
    assert_eq!(evaluate(input), Option::None);
}

#[test]
#[ignore]
fn intermediate_error_returns_none() {
    let input = calculator_input("+ 2 2 *");
    assert_eq!(evaluate(input), Option::None);
}
