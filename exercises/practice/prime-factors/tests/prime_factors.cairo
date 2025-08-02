use prime_factors::factors;

#[test]
#[ignore]
fn no_factors() {
    let factors = factors(1);
    let expected = ArrayTrait::new();
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn prime_number() {
    let factors = factors(2);
    let mut expected = ArrayTrait::new();
    expected.append(2);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn another_prime_number() {
    let factors = factors(3);
    let mut expected = ArrayTrait::new();
    expected.append(3);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn square_of_a_prime() {
    let factors = factors(9);
    let mut expected = ArrayTrait::new();
    expected.append(3);
    expected.append(3);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn product_of_first_prime() {
    let factors = factors(4);
    let mut expected = ArrayTrait::new();
    expected.append(2);
    expected.append(2);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn cube_of_a_prime() {
    let factors = factors(8);
    let mut expected = ArrayTrait::new();
    expected.append(2);
    expected.append(2);
    expected.append(2);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn product_of_second_prime() {
    let factors = factors(27);
    let mut expected = ArrayTrait::new();
    expected.append(3);
    expected.append(3);
    expected.append(3);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn product_of_third_prime() {
    let factors = factors(625);
    let mut expected = ArrayTrait::new();
    expected.append(5);
    expected.append(5);
    expected.append(5);
    expected.append(5);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn product_of_first_and_second_prime() {
    let factors = factors(6);
    let mut expected = ArrayTrait::new();
    expected.append(2);
    expected.append(3);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn product_of_primes_and_non_primes() {
    let factors = factors(12);
    let mut expected = ArrayTrait::new();
    expected.append(2);
    expected.append(2);
    expected.append(3);
    assert_eq!(factors, expected);
}
#[test]
#[ignore]
fn product_of_primes() {
    let factors = factors(901_255);
    let mut expected = ArrayTrait::new();
    expected.append(5);
    expected.append(17);
    expected.append(23);
    expected.append(461);
    assert_eq!(factors, expected);
}

#[test]
#[ignore]
fn factors_include_a_large_prime() {
    let factors = factors(93_819_012_551);
    let mut expected = ArrayTrait::new();
    expected.append(11);
    expected.append(9_539);
    expected.append(894_119);
    assert_eq!(factors, expected);
}
