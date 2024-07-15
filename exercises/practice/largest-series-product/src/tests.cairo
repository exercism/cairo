use largest_series_product::{lsp, Error};

#[test]
fn return_is_a_result() {
    let string_digits: ByteArray = "29";
    assert!(lsp(@string_digits, 2).is_ok());
}

#[test]
#[ignore]
fn finds_the_largest_product_when_span_equals_length() {
    let string_digits: ByteArray = "29";
    assert_eq!(Result::Ok(18), lsp(@string_digits, 2));
}

#[test]
#[ignore]
fn can_find_the_largest_product_of_2_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(72), lsp(@string_digits, 2));
}

#[test]
#[ignore]
fn can_find_the_largest_product_of_2() {
    let string_digits: ByteArray = "576802143";
    assert_eq!(Result::Ok(48), lsp(@string_digits, 2));
}

#[test]
#[ignore]
fn can_find_the_largest_product_of_3_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(504), lsp(@string_digits, 3));
}

#[test]
#[ignore]
fn can_find_the_largest_product_of_3() {
    let string_digits: ByteArray = "1027839564";
    assert_eq!(Result::Ok(270), lsp(@string_digits, 3));
}

#[test]
#[ignore]
fn can_find_the_largest_product_of_5_with_numbers_in_order() {
    let string_digits: ByteArray = "0123456789";
    assert_eq!(Result::Ok(15120), lsp(@string_digits, 5));
}

#[test]
#[ignore]
fn can_get_the_largest_product_of_a_big_number() {
    let string_digits: ByteArray = "73167176531330624919225119674426574742355349194934";
    assert_eq!(Result::Ok(23520), lsp(@string_digits, 6));
}

#[test]
#[ignore]
fn reports_zero_if_the_only_digits_are_zero() {
    let string_digits: ByteArray = "0000";
    assert_eq!(Result::Ok(0), lsp(@string_digits, 2));
}

#[test]
#[ignore]
fn reports_zero_if_all_spans_include_zero() {
    let string_digits: ByteArray = "99099";
    assert_eq!(Result::Ok(0), lsp(@string_digits, 3));
}

#[test]
#[ignore]
fn reports_zero_if_last_span_is_zero() {
    let string_digits: ByteArray = "999099";
    assert_eq!(Result::Ok(729), lsp(@string_digits, 3));
}

#[test]
#[ignore]
fn rejects_span_longer_than_string_length() {
    let string_digits: ByteArray = "123";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 4));
}

#[test]
#[ignore]
fn reports_1_for_empty_string_and_0_span() {
    let string_digits: ByteArray = "";
    assert_eq!(Result::Ok(1), lsp(@string_digits, 0));
}

#[test]
#[ignore]
fn reports_1_for_nonempty_string_and_0_span() {
    let string_digits: ByteArray = "1234";
    assert_eq!(Result::Ok(1), lsp(@string_digits, 0));
}

#[test]
#[ignore]
fn rejects_empty_string_and_nonzero_span() {
    let string_digits: ByteArray = "";
    assert_eq!(Result::Err(Error::SpanTooLong), lsp(@string_digits, 1));
}

#[test]
#[ignore]
fn rejects_invalid_character_in_digits() {
    let string_digits: ByteArray = "1234a5";
    assert_eq!(Result::Err(Error::InvalidDigit('a')), lsp(@string_digits, 2));
}

#[test]
#[ignore]
fn rejects_negative_span() {
    let string_digits: ByteArray = "12345";
    assert_eq!(Result::Err(Error::NegativeSpan), lsp(@string_digits, -1));
}

// Additional tests for this track
// Taken from https://github.com/exercism/python/blob/367faf4c12c172bbd981d41f4426f1ae2f0b1f49/exercises/practice/largest-series-product/largest_series_product_test.py#L72
#[test]
#[ignore]
fn euler_big_number() {
    let string_digits: ByteArray =
        "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450";
    assert_eq!(Result::Ok(23_514_624_000), lsp(@string_digits, 13));
}
