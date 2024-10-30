use binary_search_tree::{Bts, BtsTrait, Node};

fn assert_bts_equal(ref lhs: Bts, ref rhs: Bts) {
    assert!(lhs.count == rhs.count);

    for i in 0_u256
        ..lhs
            .count
            .into() {
                let left = lhs.elements.get(i.try_into().unwrap()).deref_or(Default::default());
                let right = rhs.elements.get(i.try_into().unwrap()).deref_or(Default::default());
                assert_eq!(left, right);
            };
}

fn nullable_node(elem: u32, left: Option<felt252>, right: Option<felt252>) -> Nullable<Node> {
    NullableTrait::new(Node { elem, left, right })
}

#[test]
fn data_is_retained() {
    let mut expected: Bts = Default::default();
    expected.elements.insert(0, nullable_node(4, Option::None, Option::None));
    expected.count = 1;

    let mut actual = BtsTrait::new(array![4].span());
    assert_bts_equal(ref expected, ref actual);
}

#[test]
#[ignore]
fn smaller_number_at_left_node() {
    let mut expected: Bts = Default::default();
    expected.elements.insert(0, nullable_node(4, Option::Some(1), Option::None));
    expected.elements.insert(1, nullable_node(2, Option::None, Option::None));
    expected.count = 2;

    let mut actual = BtsTrait::new(array![4, 2].span());
    assert_bts_equal(ref expected, ref actual);
}

#[test]
#[ignore]
fn same_number_at_left_node() {
    let mut expected: Bts = Default::default();
    expected.elements.insert(0, nullable_node(4, Option::Some(1), Option::None));
    expected.elements.insert(1, nullable_node(4, Option::None, Option::None));
    expected.count = 2;

    let mut actual = BtsTrait::new(array![4, 4].span());
    assert_bts_equal(ref expected, ref actual);
}

#[test]
#[ignore]
fn greater_number_at_right_node() {
    let mut expected: Bts = Default::default();
    expected.elements.insert(0, nullable_node(4, Option::None, Option::Some(1)));
    expected.elements.insert(1, nullable_node(5, Option::None, Option::None));
    expected.count = 2;

    let mut actual = BtsTrait::new(array![4, 5].span());
    assert_bts_equal(ref expected, ref actual);
}

#[test]
#[ignore]
fn can_create_complex_tree() {
    let mut expected: Bts = Default::default();
    expected.elements.insert(0, nullable_node(4, Option::Some(1), Option::Some(2)));
    expected.elements.insert(1, nullable_node(2, Option::Some(3), Option::Some(4)));
    expected.elements.insert(2, nullable_node(6, Option::Some(5), Option::Some(6)));
    expected.elements.insert(3, nullable_node(1, Option::None, Option::None));
    expected.elements.insert(4, nullable_node(3, Option::None, Option::None));
    expected.elements.insert(5, nullable_node(5, Option::None, Option::None));
    expected.elements.insert(6, nullable_node(7, Option::None, Option::None));
    expected.count = 7;

    let mut actual = BtsTrait::new(array![4, 2, 6, 1, 3, 5, 7].span());
    assert_bts_equal(ref expected, ref actual);
}

#[test]
#[ignore]
fn can_sort_single_number() {
    let mut bts = BtsTrait::new(array![2].span());
    let expected = array![2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_smaller_than_first() {
    let mut bts = BtsTrait::new(array![2, 1].span());
    let expected = array![1, 2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_same_as_first() {
    let mut bts = BtsTrait::new(array![2, 2].span());
    let expected = array![2, 2].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_if_second_number_is_greater_than_first() {
    let mut bts = BtsTrait::new(array![2, 3].span());
    let expected = array![2, 3].span();
    assert_eq!(expected, bts.sorted_data());
}

#[test]
#[ignore]
fn can_sort_complex_tree() {
    let mut bts = BtsTrait::new(array![2, 1, 3, 6, 7, 5].span());
    let expected = array![1, 2, 3, 5, 6, 7].span();
    assert_eq!(expected, bts.sorted_data());
}
