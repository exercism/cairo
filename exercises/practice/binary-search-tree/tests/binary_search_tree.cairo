use binary_search_tree::BinarySearchTreeTrait as BinarySearchTree;

#[test]
fn data_is_retained() {
    let bst = BinarySearchTree::new(array![4].span());
    assert_eq!(Option::Some(4), bst.value());
}

#[test]
#[ignore]
fn smaller_number_at_left_node() {
    let bst = BinarySearchTree::new(array![4, 2].span());
    assert_eq!(Option::Some(4), bst.value());
    assert_eq!(Option::Some(2), bst.left().value());
}

#[test]
#[ignore]
fn same_number_at_left_node() {
    let bst = BinarySearchTree::new(array![4, 4].span());
    assert_eq!(Option::Some(4), bst.value());
    assert_eq!(Option::Some(4), bst.left().value());
}

#[test]
#[ignore]
fn greater_number_at_right_node() {
    let bst = BinarySearchTree::new(array![4, 5].span());
    assert_eq!(Option::Some(4), bst.value());
    assert_eq!(Option::Some(5), bst.right().value());
}

#[test]
#[ignore]
fn can_create_complex_tree() {
    let bst = BinarySearchTree::new(array![4, 2, 6, 1, 3, 5, 7].span());
    assert_eq!(Option::Some(4), bst.value());
    assert_eq!(Option::Some(2), bst.left().value());
    assert_eq!(Option::Some(6), bst.right().value());
    assert_eq!(Option::Some(1), bst.left().left().value());
    assert_eq!(Option::Some(3), bst.left().right().value());
    assert_eq!(Option::Some(5), bst.right().left().value());
    assert_eq!(Option::Some(7), bst.right().right().value());
}

#[test]
#[ignore]
fn can_sort_single_number() {
    let mut bts = BinarySearchTree::new(array![2].span());
    let expected = array![2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_smaller_than_first() {
    let mut bts = BinarySearchTree::new(array![2, 1].span());
    let expected = array![1, 2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_same_as_first() {
    let mut bts = BinarySearchTree::new(array![2, 2].span());
    let expected = array![2, 2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_greater_than_first() {
    let mut bts = BinarySearchTree::new(array![2, 3].span());
    let expected = array![2, 3].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_complex_tree() {
    let mut bts = BinarySearchTree::new(array![2, 1, 3, 6, 7, 5].span());
    let expected = array![1, 2, 3, 5, 6, 7].span();
    assert_eq!(expected, bts.sorted_data());
}
