use sum_of_multiples::sum_of_multiples;

#[test]
fn no_multiples_within_limit() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(5);
    let limit = 1;
    let output = sum_of_multiples(limit, factors);
    assert(output == 0, 'Test failed: Expected 0.');
}

#[test]
#[ignore]
fn one_factor_has_multiples_within_limit() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(5);
    let limit = 4;
    let output = sum_of_multiples(limit, factors);
    assert(output == 3, 'Test failed: Expected 3.');
}

#[test]
#[ignore]
fn more_than_one_multiple_within_limit() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    let limit = 7;
    let output = sum_of_multiples(limit, factors);
    assert(output == 9, 'Test failed: Expected 9.');
}

#[test]
#[ignore]
fn more_than_one_factor_with_multiples_within_limit() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(5);
    let limit = 10;
    let output = sum_of_multiples(limit, factors);
    assert(output == 23, 'Test failed: Expected 23.');
}

#[test]
#[ignore]
fn each_multiple_is_only_counted_once() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(5);
    let limit = 100;
    let output = sum_of_multiples(limit, factors);
    assert(output == 2318, 'Test failed: Expected 2318.');
}

#[test]
#[ignore]
fn a_much_larger_limit() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(5);
    let limit = 1000;
    let output = sum_of_multiples(limit, factors);
    assert(output == 233168, 'Test failed: Expected 233168.');
}

#[test]
#[ignore]
fn three_factors() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(7);
    factors.append(13);
    factors.append(17);
    let limit = 20;
    let output = sum_of_multiples(limit, factors);
    assert(output == 51, 'Test failed: Expected 51.');
}

#[test]
#[ignore]
fn factors_not_relatively_prime() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(4);
    factors.append(6);
    let limit = 15;
    let output = sum_of_multiples(limit, factors);
    assert(output == 30, 'Test failed: Expected 30.');
}

#[test]
#[ignore]
fn some_pairs_of_factors_relatively_prime_and_some_not() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(5);
    factors.append(6);
    factors.append(8);
    let limit = 150;
    let output = sum_of_multiples(limit, factors);
    assert(output == 4419, 'Test failed: Expected 4419.');
}

#[test]
#[ignore]
fn one_factor_is_a_multiple_of_another() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(5);
    factors.append(25);
    let limit = 51;
    let output = sum_of_multiples(limit, factors);
    assert(output == 275, 'Test failed: Expected 275.');
}

#[test]
#[ignore]
fn much_larger_factors() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(43);
    factors.append(47);
    let limit = 10000;
    let output = sum_of_multiples(limit, factors);
    assert(output == 2203160, 'Test failed: Expected 2203160.');
}

#[test]
#[ignore]
fn all_numbers_are_multiples_of_1() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(1);
    let limit = 100;
    let output = sum_of_multiples(limit, factors);
    assert(output == 4950, 'Test failed: Expected 4950.');
}

#[test]
#[ignore]
fn no_factors_means_an_empty_sum() {
    let mut factors: Array<u32> = ArrayTrait::new();
    let limit = 10000;
    let output = sum_of_multiples(limit, factors);
    assert(output == 0, 'Test failed: Expected 0.');
}

#[test]
#[ignore]
fn the_only_multiple_of_0_is_0() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(0);
    let limit = 1;
    let output = sum_of_multiples(limit, factors);
    assert(output == 0, 'Test failed: Expected 0.');
}

#[test]
#[ignore]
fn the_factor_0_does_not_affect_the_sum_of_multiples_of_other_factors() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(3);
    factors.append(0);
    let limit = 4;
    let output = sum_of_multiples(limit, factors);
    assert(output == 3, 'Test failed: Expected 3.');
}

#[test]
#[ignore]
fn solutions_using_include_exclude_must_extend_to_cardinality_greater_than_3() {
    let mut factors: Array<u32> = ArrayTrait::new();
    factors.append(2);
    factors.append(3);
    factors.append(5);
    factors.append(7);
    factors.append(11);
    let limit = 1500;
    let output = sum_of_multiples(limit, factors);
    assert(output == 888403, 'Test failed: Expected 888403.');
}
