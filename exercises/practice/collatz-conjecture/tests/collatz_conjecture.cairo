use collatz_conjecture::steps;

#[test]
fn zero_steps_for_one() {
    assert_eq!(steps(1), Option::Some(0));
}

#[test]
#[ignore]
fn divide_if_even() {
    assert_eq!(steps(16), Option::Some(4));
}

#[test]
#[ignore]
fn even_and_odd_steps() {
    assert_eq!(steps(12), Option::Some(9));
}

#[test]
#[ignore]
fn large_number_of_even_and_odd_steps() {
    assert_eq!(steps(1000000), Option::Some(152));
}

#[test]
#[ignore]
fn zero_is_an_error() {
    assert_eq!(steps(0), Option::None);
}
