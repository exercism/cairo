use sum_of_multiples::sum;

#[test]
fn no_multiples_within_limit() {
    let factors: Array<u32> = array![3, 5];
    let limit = 1;
    let output = sum(limit, factors);
    assert_eq!(output, 0);
}

#[test]
#[ignore]
fn one_factor_has_multiples_within_limit() {
    let factors: Array<u32> = array![3, 5];
    let limit = 4;
    let output = sum(limit, factors);
    assert_eq!(output, 3);
}

#[test]
#[ignore]
fn more_than_one_multiple_within_limit() {
    let factors: Array<u32> = array![3];
    let limit = 7;
    let output = sum(limit, factors);
    assert_eq!(output, 9);
}

#[test]
#[ignore]
fn more_than_one_factor_with_multiples_within_limit() {
    let factors: Array<u32> = array![3, 5];
    let limit = 10;
    let output = sum(limit, factors);
    assert_eq!(output, 23);
}

#[test]
#[ignore]
fn each_multiple_is_only_counted_once() {
    let factors: Array<u32> = array![3, 5];
    let limit = 100;
    let output = sum(limit, factors);
    assert_eq!(output, 2318);
}

#[test]
#[ignore]
fn a_much_larger_limit() {
    let factors: Array<u32> = array![3, 5];
    let limit = 1000;
    let output = sum(limit, factors);
    assert_eq!(output, 233168);
}

#[test]
#[ignore]
fn three_factors() {
    let factors: Array<u32> = array![7, 13, 17];
    let limit = 20;
    let output = sum(limit, factors);
    assert_eq!(output, 51);
}

#[test]
#[ignore]
fn factors_not_relatively_prime() {
    let factors: Array<u32> = array![4, 6];
    let limit = 15;
    let output = sum(limit, factors);
    assert_eq!(output, 30);
}

#[test]
#[ignore]
fn some_pairs_of_factors_relatively_prime_and_some_not() {
    let factors: Array<u32> = array![5, 6, 8];
    let limit = 150;
    let output = sum(limit, factors);
    assert_eq!(output, 4419);
}

#[test]
#[ignore]
fn one_factor_is_a_multiple_of_another() {
    let factors: Array<u32> = array![5, 25];
    let limit = 51;
    let output = sum(limit, factors);
    assert_eq!(output, 275);
}

#[test]
#[ignore]
fn much_larger_factors() {
    let factors: Array<u32> = array![43, 47];
    let limit = 10000;
    let output = sum(limit, factors);
    assert_eq!(output, 2203160);
}

#[test]
#[ignore]
fn all_numbers_are_multiples_of_1() {
    let factors: Array<u32> = array![1];
    let limit = 100;
    let output = sum(limit, factors);
    assert_eq!(output, 4950);
}

#[test]
#[ignore]
fn no_factors_means_an_empty_sum() {
    let factors: Array<u32> = array![];
    let limit = 10000;
    let output = sum(limit, factors);
    assert_eq!(output, 0);
}

#[test]
#[ignore]
fn the_only_multiple_of_0_is_0() {
    let factors: Array<u32> = array![0];
    let limit = 1;
    let output = sum(limit, factors);
    assert_eq!(output, 0);
}

#[test]
#[ignore]
fn the_factor_0_does_not_affect_the_sum_of_multiples_of_other_factors() {
    let factors: Array<u32> = array![3, 0];
    let limit = 4;
    let output = sum(limit, factors);
    assert_eq!(output, 3);
}

#[test]
#[ignore]
fn solutions_using_include_exclude_must_extend_to_cardinality_greater_than_3() {
    let factors: Array<u32> = array![2, 3, 5, 7, 11];
    let limit = 1500;
    let output = sum(limit, factors);
    assert_eq!(output, 888403);
}
