use variable_length_quantity::{encode, decode};

#[test]
fn zero() {
    let integers = array![0];
    let expected = array![0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn arbitrary_single_byte() {
    let integers = array![64];
    let expected = array![64];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn largest_single_byte() {
    let integers = array![127];
    let expected = array![127];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn smallest_double_byte() {
    let integers = array![128];
    let expected = array![129, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn arbitrary_double_byte() {
    let integers = array![8192];
    let expected = array![192, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn largest_double_byte() {
    let integers = array![16383];
    let expected = array![255, 127];

    let result = encode(integers);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn smallest_triple_byte() {
    let integers = array![16384];
    let expected = array![129, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn arbitrary_triple_byte() {
    let integers = array![1048576];
    let expected = array![192, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn largest_triple_byte() {
    let integers = array![2097151];
    let expected = array![255, 255, 127];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn smallest_quadruple_byte() {
    let integers = array![2097152];
    let expected = array![129, 128, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn arbitrary_quadruple_byte() {
    let integers = array![134217728];
    let expected = array![192, 128, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn largest_quadruple_byte() {
    let integers = array![268435455];
    let expected = array![255, 255, 255, 127];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn smallest_quintuple_byte() {
    let integers = array![268435456];
    let expected = array![129, 128, 128, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn arbitrary_quintuple_byte() {
    let integers = array![4278190080];
    let expected = array![143, 248, 128, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn maximum_32_bit_integer_input() {
    let integers = array![4294967295];
    let expected = array![143, 255, 255, 255, 127];

    let result = encode(integers);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn two_single_byte_values() {
    let integers = array![64, 127];
    let expected = array![64, 127];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn two_multi_byte_values() {
    let integers = array![16384, 1193046];
    let expected = array![129, 128, 0, 200, 232, 86];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn many_multi_byte_values() {
    let integers = array![8192, 1193046, 268435455, 0, 16383, 16384];
    let expected = array![192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0];

    let result = encode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn one_byte() {
    let integers = array![127];
    let expected = array![127];

    let result = decode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn two_byte() {
    let integers = array![192, 0];
    let expected = array![8192];

    let result = decode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn three_byte() {
    let integers = array![255, 255, 127];
    let expected = array![2097151];

    let result = decode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn four_byte() {
    let integers = array![129, 128, 128, 0];
    let expected = array![2097152];

    let result = decode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn maximum_32_bit_integer() {
    let integers = array![143, 255, 255, 255, 127];
    let expected = array![4294967295];

    let result = decode(integers);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("incomplete sequence",))]
fn incomplete_sequence_causes_error() {
    let integers = array![255];
    let _ = decode(integers);
}

#[test]
#[ignore]
#[should_panic(expected: ("incomplete sequence",))]
fn incomplete_sequence_causes_error_even_if_value_is_zero() {
    let integers = array![128];
    let _ = decode(integers);
}


#[test]
#[ignore]
fn multiple_values() {
    let integers = array![192, 0, 200, 232, 86, 255, 255, 255, 127, 0, 255, 127, 129, 128, 0];
    let expected = array![8192, 1193046, 268435455, 0, 16383, 16384];

    let result = decode(integers);

    assert_eq!(result, expected);
}
