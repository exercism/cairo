use binary_search::find;

#[test]
#[ignore]
fn finds_a_value_in_an_array_with_one_element() {
    let arr: Array<u32> = array![6];
    assert_eq!(find(@arr, 6), Option::Some(0));
}

#[test]
#[ignore]
fn finds_first_value_in_an_array_with_two_element() {
    let arr: Array<u32> = array![1, 2];
    assert_eq!(find(@arr, 1), Option::Some(0));
}

#[test]
#[ignore]
fn finds_second_value_in_an_array_with_two_element() {
    let arr: Array<u32> = array![1, 2];
    assert_eq!(find(@arr, 2), Option::Some(1));
}

#[test]
#[ignore]
fn finds_a_value_in_the_middle_of_an_array() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 6), Option::Some(3));
}

#[test]
#[ignore]
fn finds_a_value_at_the_beginning_of_an_array() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 1), Option::Some(0));
}

#[test]
#[ignore]
fn finds_a_value_at_the_end_of_an_array() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 11), Option::Some(6));
}

#[test]
#[ignore]
fn finds_a_value_in_an_array_of_odd_length() {
    let arr: Array<u32> = array![1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634];
    assert_eq!(find(@arr, 144), Option::Some(9));
}

#[test]
#[ignore]
fn finds_a_value_in_an_array_of_even_length() {
    let arr: Array<u32> = array![1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377];
    assert_eq!(find(@arr, 21), Option::Some(5));
}

const OPTION_NONE: Option<usize> = Option::None;

#[test]
#[ignore]
fn identifies_that_a_value_is_not_included_in_the_array() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 7), OPTION_NONE);
}

#[test]
#[ignore]
fn a_value_smaller_than_the_arrays_smallest_value_is_not_found() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 0), OPTION_NONE);
}

#[test]
#[ignore]
fn a_value_larger_than_the_arrays_largest_value_is_not_found() {
    let arr: Array<u32> = array![1, 3, 4, 6, 8, 9, 11];
    assert_eq!(find(@arr, 13), OPTION_NONE);
}

#[test]
#[ignore]
fn nothing_is_found_in_an_empty_array() {
    let arr: Array<u32> = array![];
    assert_eq!(find(@arr, 1), OPTION_NONE);
}

#[test]
#[ignore]
fn nothing_is_found_when_the_left_and_right_bounds_cross() {
    let arr: Array<u32> = array![1, 2];
    assert_eq!(find(@arr, 0), OPTION_NONE);
}
