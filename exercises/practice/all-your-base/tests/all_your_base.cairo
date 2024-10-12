use all_your_base::{convert, Error};

#[test]
fn single_bit_one_to_decimal() {
    let input_base = 2;
    let input_digits: Array<u32> = array![1];
    let output_base = 10;

    let expected_output = Result::Ok(array![1]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn binary_to_single_decimal() {
    let input_base = 2;
    let input_digits: Array<u32> = array![1, 0, 1];
    let output_base = 10;

    let expected_output = Result::Ok(array![5]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn single_decimal_to_binary() {
    let input_base = 10;
    let input_digits = array![5];
    let output_base = 2;

    let expected_output = Result::Ok(array![1, 0, 1]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}


#[test]
#[ignore]
fn binary_to_multiple_decimal() {
    let input_base = 2;
    let input_digits = array![1, 0, 1, 0, 1, 0];
    let output_base = 10;

    let expected_output = Result::Ok(array![4, 2]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn decimal_to_binary() {
    let input_base = 10;
    let input_digits = array![4, 2];
    let output_base = 2;

    let expected_output = Result::Ok(array![1, 0, 1, 0, 1, 0]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn trinary_to_hexadecimal() {
    let input_base = 3;
    let input_digits = array![1, 1, 2, 0];
    let output_base = 16;

    let expected_output = Result::Ok(array![2, 10]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn hexadecimal_to_trinary() {
    let input_base = 16;
    let input_digits = array![2, 10];
    let output_base = 3;

    let expected_output = Result::Ok(array![1, 1, 2, 0]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn test_15_bit_integer() {
    let input_base = 97;
    let input_digits = array![3, 46, 60];
    let output_base = 73;

    let expected_output = Result::Ok(array![6, 10, 45]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}


#[test]
#[ignore]
fn empty_list() {
    let input_base = 2;
    let input_digits = array![];
    let output_base = 10;

    let expected_output = Result::Ok(array![0]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn single_zero() {
    let input_base = 10;
    let input_digits = array![0];
    let output_base = 2;

    let expected_output = Result::Ok(array![0]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn multiple_zeros() {
    let input_base = 10;
    let input_digits = array![0, 0, 0];
    let output_base = 2;

    let expected_output = Result::Ok(array![0]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn leading_zeros() {
    let input_base = 7;
    let input_digits = array![0, 6, 0];
    let output_base = 10;

    let expected_output = Result::Ok(array![4, 2]);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn input_base_is_one() {
    let input_base = 1;
    let input_digits = array![0];
    let output_base = 10;

    let expected_output = Result::Err(Error::InvalidInputBase);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn input_base_is_zero() {
    let input_base = 0;
    let input_digits = array![];
    let output_base = 10;

    let expected_output = Result::Err(Error::InvalidInputBase);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn invalid_positive_digit() {
    let input_base = 2;
    let input_digits = array![1, 2, 1, 0, 1, 0];
    let output_base = 10;

    let expected_output = Result::Err(Error::InvalidDigit(2));
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}


#[test]
#[ignore]
fn output_base_is_one() {
    let input_base = 2;
    let input_digits = array![1, 0, 1, 0, 1, 0];
    let output_base = 1;

    let expected_output = Result::Err(Error::InvalidOutputBase);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}

#[test]
#[ignore]
fn output_base_is_zero() {
    let input_base = 10;
    let input_digits = array![7];
    let output_base = 0;

    let expected_output = Result::Err(Error::InvalidOutputBase);
    let result = convert(input_digits, input_base, output_base);

    assert_eq!(result, expected_output);
}
