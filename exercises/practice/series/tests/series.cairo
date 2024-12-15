use series::slices;

#[test]
fn slices_of_one_from_one() {
    let input = "1";
    let length = 1;
    let output = slices(input, length);
    let expected = array!["1"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn slices_of_one_from_two() {
    let input = "12";
    let length = 1;
    let output = slices(input, length);
    let expected = array!["1", "2"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn slices_of_two() {
    let input = "35";
    let length = 2;
    let output = slices(input, length);
    let expected = array!["35"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn slices_of_two_overlap() {
    let input = "9142";
    let length = 2;
    let output = slices(input, length);
    let expected = array!["91", "14", "42"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn slices_can_include_duplicates() {
    let input = "777777";
    let length = 3;
    let output = slices(input, length);
    let expected = array!["777", "777", "777", "777"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn slices_of_a_long_series() {
    let input = "918493904243";
    let length = 5;
    let output = slices(input, length);
    let expected = array!["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("slice length cannot be greater than series length",))]
fn slice_length_is_too_large() {
    let input = "12345";
    let length = 6;
    slices(input, length);
}

#[test]
#[ignore]
#[should_panic(expected: ("slice length cannot be greater than series length",))]
fn slice_length_is_way_too_large() {
    let input = "12345";
    let length = 42;
    slices(input, length);
}

#[test]
#[ignore]
#[should_panic(expected: ("slice length cannot be zero",))]
fn slice_length_cannot_be_zero() {
    let input = "12345";
    let length = 0;
    slices(input, length);
}

#[test]
#[ignore]
#[should_panic(expected: ("series cannot be empty",))]
fn empty_series_is_invalid() {
    let input = "";
    let length = 1;
    slices(input, length);
}
