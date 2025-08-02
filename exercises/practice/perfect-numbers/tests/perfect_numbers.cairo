use perfect_numbers::{classify, Classification};

// Perfect numbers

#[test]
#[ignore]
fn smallest_perfect_number() {
    assert_eq!(classify(6), Classification::Perfect);
}

#[test]
#[ignore]
fn medium_perfect_number() {
    assert_eq!(classify(28), Classification::Perfect);
}

#[test]
#[ignore]
fn large_perfect_number() {
    assert_eq!(classify(33550336), Classification::Perfect);
}

// Abundant numbers

#[test]
#[ignore]
fn smallest_abundant_number() {
    assert_eq!(classify(12), Classification::Abundant);
}

#[test]
#[ignore]
fn medium_abundant_number() {
    assert_eq!(classify(30), Classification::Abundant);
}

#[test]
#[ignore]
fn large_abundant_number() {
    assert_eq!(classify(33550335), Classification::Abundant);
}

// Deficient numbers

#[test]
#[ignore]
fn smallest_prime_deficient_number() {
    assert_eq!(classify(2), Classification::Deficient);
}

#[test]
#[ignore]
fn smallest_non_prime_deficient_number() {
    assert_eq!(classify(4), Classification::Deficient);
}

#[test]
#[ignore]
fn medium_deficient_number() {
    assert_eq!(classify(32), Classification::Deficient);
}

#[test]
#[ignore]
fn large_deficient_number() {
    assert_eq!(classify(33550337), Classification::Deficient);
}

#[test]
#[ignore]
fn edge_case_no_factors_other_than_itself() {
    assert_eq!(classify(1), Classification::Deficient);
}

// Invalid inputs

#[test]
#[ignore]
#[should_panic(expected: ("Classification is only possible for positive integers.",))]
fn zero_is_rejected() {
    classify(0);
}
