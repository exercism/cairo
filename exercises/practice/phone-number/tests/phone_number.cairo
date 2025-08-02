use phone_number::clean;

#[test]
#[ignore]
fn cleans_the_number() {
    let output = clean("(223) 456-7890");
    let expected = "2234567890";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn cleans_numbers_with_dots() {
    let output = clean("223.456.7890");
    let expected = "2234567890";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn cleans_numbers_with_multiple_spaces() {
    let output = clean("223 456   7890   ");
    let expected = "2234567890";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("must not be fewer than 10 digits",))]
fn invalid_when_9_digits() {
    clean("123456789");
}

#[test]
#[ignore]
#[should_panic(expected: ("11 digits must start with 1",))]
fn invalid_when_11_digits_does_not_start_with_a_1() {
    clean("22234567890");
}

#[test]
#[ignore]
fn valid_when_11_digits_and_starting_with_1() {
    let output = clean("12234567890");
    let expected = "2234567890";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn valid_when_11_digits_and_starting_with_1_even_with_punctuation() {
    let output = clean("+1 (223) 456-7890");
    let expected = "2234567890";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("must not be greater than 11 digits",))]
fn invalid_when_more_than_11_digits() {
    clean("321234567890");
}

#[test]
#[ignore]
#[should_panic(expected: ("letters not permitted",))]
fn invalid_with_letters() {
    clean("523-abc-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("punctuations not permitted",))]
fn invalid_with_punctuations() {
    clean("523-@:!-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("area code cannot start with zero",))]
fn invalid_if_area_code_starts_with_0() {
    clean("(023) 456-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("area code cannot start with one",))]
fn invalid_if_area_code_starts_with_1() {
    clean("(123) 456-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("exchange code cannot start with zero",))]
fn invalid_if_exchange_code_starts_with_0() {
    clean("(223) 056-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("exchange code cannot start with one",))]
fn invalid_if_exchange_code_starts_with_1() {
    clean("(223) 156-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("area code cannot start with zero",))]
fn invalid_if_area_code_starts_with_0_on_valid_11_digit_number() {
    clean("1 (023) 456-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("area code cannot start with one",))]
fn invalid_if_area_code_starts_with_1_on_valid_11_digit_number() {
    clean("1 (123) 456-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("exchange code cannot start with zero",))]
fn invalid_if_exchange_code_starts_with_0_on_valid_11_digit_number() {
    clean("1 (223) 056-7890");
}

#[test]
#[ignore]
#[should_panic(expected: ("exchange code cannot start with one",))]
fn invalid_if_exchange_code_starts_with_1_on_valid_11_digit_number() {
    clean("1 (223) 156-7890");
}
