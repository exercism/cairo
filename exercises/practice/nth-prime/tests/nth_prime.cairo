use nth_prime::prime;

#[test]
#[ignore]
fn first_prime() {
    let output = prime(1);
    let expected = 2;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn second_prime() {
    let output = prime(2);
    let expected = 3;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sixth_prime() {
    let output = prime(6);
    let expected = 13;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn big_prime() {
    let output = prime(4001);
    let expected = 37831;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("there is no zeroth prime",))]
fn there_is_no_zeroth_prime() {
    prime(0);
}
