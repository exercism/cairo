use armstrong_numbers::is_armstrong_number;

#[test]
fn zero_is_an_armstrong_number() {
    assert!(is_armstrong_number(0), "0 is an Armstrong number")
}

#[test]
#[ignore]
fn single_digit_numbers_are_armstrong_numbers() {
    assert!(is_armstrong_number(5), "5 is an Armstrong number")
}

#[test]
#[ignore]
fn there_are_no_2_digit_armstrong_numbers() {
    assert!(!is_armstrong_number(10), "10 is NOT an Armstrong number")
}

#[test]
#[ignore]
fn three_digit_armstrong_number() {
    assert!(is_armstrong_number(153), "153 is an Armstrong number")
}

#[test]
#[ignore]
fn three_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(100), "100 is NOT an Armstrong number")
}

#[test]
#[ignore]
fn four_digit_armstrong_number() {
    assert!(is_armstrong_number(9474), "9474 is an Armstrong number")
}

#[test]
#[ignore]
fn four_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(9475), "9475 is NOT an Armstrong number")
}

#[test]
#[ignore]
fn seven_digit_armstrong_number() {
    assert!(is_armstrong_number(9_926_315), "9926315 is an Armstrong number")
}

#[test]
#[ignore]
fn seven_digit_non_armstrong_number() {
    assert!(!is_armstrong_number(9_926_316), "9_926_316 is NOT an Armstrong number")
}

#[test]
#[ignore]
fn armstrong_number_containing_seven_zeroes() {
    assert!(
        is_armstrong_number(186_709_961_001_538_790_100_634_132_976_990),
        "186709961001538790100634132976990 is an Armstrong number"
    )
}

#[test]
#[ignore]
fn the_largest_and_last_armstrong_number() {
    assert!(
        is_armstrong_number(115_132_219_018_763_992_565_095_597_973_971_522_401),
        "115132219018763992565095597973971522401 is an Armstrong number"
    )
}
