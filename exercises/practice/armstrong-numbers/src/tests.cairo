use armstrong_numbers::is_armstrong_number;

#[test]
fn zero_is_an_armstrong_number() {
    assert!(is_armstrong_number(0))
}

#[test]
fn single_digit_numbers_are_armstrong_numbers() {
    assert!(is_armstrong_number(5))
}

#[test]
fn there_are_no_2_digit_armstrong_numbers() {
    assert!(!is_armstrong_number(10))
}

#[test]
fn three_digit_armstrong_number() {
    assert!(is_armstrong_number(153))
}

#[test]
fn three_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(100))
}

#[test]
fn four_digit_armstrong_number() {
    assert!(is_armstrong_number(9474))
}

#[test]
fn four_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(9475))
}

#[test]
fn seven_digit_armstrong_number() {
    assert!(is_armstrong_number(9_926_315))
}

#[test]
fn seven_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(9_926_316))
}

#[test]
fn armstrong_number_containing_seven_zeroes() {
    assert!(is_armstrong_number(186_709_961_001_538_790_100_634_132_976_990));
}

#[test]
fn the_largest_and_last_armstrong_number() {
    assert!(is_armstrong_number(115_132_219_018_763_992_565_095_597_973_971_522_401));
}
