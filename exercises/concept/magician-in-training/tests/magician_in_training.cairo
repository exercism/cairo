use magician_in_training::*;

#[test]
fn insert_top_test() {
    let queue = array![5, 9, 7, 1];
    let actual = insert_top(queue, 8);
    let expected = array![5, 9, 7, 1, 8];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn remove_top_card_with_empty_stack_test() {
    let queue = array![];
    let actual = remove_top_card(queue);
    let expected = array![];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn remove_top_card_test() {
    let queue = array![5, 9, 7, 1];
    let actual = remove_top_card(queue);
    let expected = array![5, 9, 7];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn insert_bottom_test() {
    let queue = array![5, 9, 7, 1];
    let actual = insert_bottom(queue, 8);
    let expected = array![8, 5, 9, 7, 1];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn remove_bottom_card_with_empty_stack_test() {
    let queue = array![];
    let actual = remove_bottom_card(queue);
    let expected = array![];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn remove_bottom_card_test() {
    let queue = array![5, 9, 7, 1];
    let actual = remove_bottom_card(queue);
    let expected = array![9, 7, 1];
    assert_eq!(expected, actual);
}

#[test]
#[ignore]
fn check_size_of_stack_not_matching_test() {
    let queue = array![5, 9, 7, 1];
    assert!(!check_size_of_stack(queue, 5));
}

#[test]
#[ignore]
fn check_size_of_stack_matching_test() {
    let queue = array![5, 9, 7, 1];
    assert!(check_size_of_stack(queue, 4));
}
