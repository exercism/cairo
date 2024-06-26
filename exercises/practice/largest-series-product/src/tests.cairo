use largest_series_product::{lsp, Error};

#[test]
fn return_is_a_result() {
    let string_digits: ByteArray = "29";
    assert!(lsp(@string_digits, 2).is_ok());
}

#[test]
fn finds_the_largest_product_when_span_equals_length() {
    let string_digits: ByteArray = "29";
    assert_eq!(Result::Ok(18), lsp(@string_digits, 2));
}

#[test]
fn can_find_the_largest_product_of_2_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(72), lsp(@string_digits, 2));
}

#[test]
fn can_find_the_largest_product_of_2() {
    let string_digits: ByteArray = "576802143";
    assert_eq!(Result::Ok(48), lsp(@string_digits, 2));
}

#[test]
fn can_find_the_largest_product_of_3_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(504), lsp(@string_digits, 3));
}

#[test]
fn can_find_the_largest_product_of_3() {
    let string_digits: ByteArray = "1027839564";
    assert_eq!(Result::Ok(270), lsp(@string_digits, 3));
}

#[test]
fn can_find_the_largest_product_of_5_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(15120), lsp(@string_digits, 5));
}

#[test]
fn can_get_the_largest_product_of_a_big_number() {
    let string_digits: ByteArray = "73167176531330624919225119674426574742355349194934";
    assert_eq!(Result::Ok(23520), lsp(@string_digits, 6));
}

#[test]
fn reports_zero_if_the_only_digits_are_zero() {
    let string_digits: ByteArray = "0000";
    assert_eq!(Result::Ok(0), lsp(@string_digits, 2));
}

#[test]
fn reports_zero_if_all_spans_include_zero() {
    let string_digits: ByteArray = "99099";
    assert_eq!(Result::Ok(0), lsp(@string_digits, 3));
}

#[test]
fn rejects_span_longer_than_string_length() {
    let string_digits: ByteArray = "123";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 4));
}

#[test]
fn reports_1_for_empty_string_and_0_span() {
    let string_digits: ByteArray = "";
    assert_eq!(Result::Ok(1), lsp(@string_digits, 0));
}

#[test]
fn reports_1_for_nonempty_string_and_0_span() {
    let string_digits: ByteArray = "1234";
    assert_eq!(Result::Ok(1), lsp(@string_digits, 0));
}

#[test]
fn rejects_empty_string_and_nonzero_span() {
    let string_digits: ByteArray = "";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 1));
}

#[test]
fn rejects_invalid_character_in_digits() {
    let string_digits: ByteArray = "1234a5";
    assert_eq!(Result::Err(Error::InvalidDigit('a')), lsp(@string_digits, 2));
}

#[test]
fn rejects_negative_span() {
    let string_digits: ByteArray = "12345";
    assert_eq!(Result::Err(Error::NegativeSpan), lsp(@string_digits, -1));
}
