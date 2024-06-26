use largest_series_product::{lsp, Error};

#[test]
fn return_is_a_result() {
    let string_digits: ByteArray = "29";
    assert!(lsp(@string_digits, 2).is_ok());
}

#[test]
fn find_the_largest_product_when_span_equals_length() {
    let string_digits: ByteArray = "29";
    assert_eq!(Result::Ok(18_u64), lsp(@string_digits, 2));
}

#[test]
fn find_the_largest_product_of_two_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(72_u64), lsp(@string_digits, 2));
}

#[test]
fn find_the_largest_product_of_two_with_numbers_not_in_order() {
    let string_digits: ByteArray = "576802143";
    assert_eq!(Result::Ok(48_u64), lsp(@string_digits, 2));
}

#[test]
fn find_the_largest_product_of_three_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(504_u64), lsp(@string_digits, 3));
}

#[test]
fn find_the_largest_product_of_three_with_numbers_not_in_order() {
    let string_digits: ByteArray = "1027839564";
    assert_eq!(Result::Ok(270_u64), lsp(@string_digits, 3));
}

#[test]
fn find_the_largest_product_of_five_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(15_120_u64), lsp(@string_digits, 5));
}

#[test]
fn span_of_six_in_a_large_number() {
    let string_digits: ByteArray = "73167176531330624919225119674426574742355349194934";
    assert_eq!(Result::Ok(23_520_u64), lsp(@string_digits, 6));
}

#[test]
fn returns_zero_if_number_is_zeros() {
    let string_digits: ByteArray = "0000";
    assert_eq!(Result::Ok(0_u64), lsp(@string_digits, 2));
}

#[test]
fn returns_zero_if_all_products_are_zero() {
    let string_digits: ByteArray = "99099";
    assert_eq!(Result::Ok(0_u64), lsp(@string_digits, 3));
}

#[test]
fn a_span_is_longer_than_number_is_an_error() {
    let string_digits: ByteArray = "123";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 4));
}

#[test]
fn empty_string_and_non_zero_span_is_an_error() {
    let string_digits: ByteArray = "";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 1));
}

#[test]
fn a_string_with_non_digits_is_an_error() {
    let string_digits: ByteArray = "1234a5";
    assert_eq!(Result::Err(Error::InvalidDigit('a')), lsp(@string_digits, 2));
}
