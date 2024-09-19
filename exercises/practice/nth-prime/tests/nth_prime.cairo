use nth_prime::nth;

#[test]
fn first_prime() {
    let output = nth(1);
    let expected = 2;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn second_prime() {
    let output = nth(2);
    let expected = 3;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sixth_prime() {
    let output = nth(6);
    let expected = 13;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn big_prime() {
    let output = nth(1000);
    let expected = 7919;
    assert_eq!(output, expected);
}

#[test]
#[should_panic(expected: ("there is no zeroth prime",))]
fn there_is_no_zeroth_prime() {
    nth(0);
}
