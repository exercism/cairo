use zipper::{ZipperTrait as Zipper, BinaryTreeTrait as BinaryTree, BinaryTreePartialEq};

#[test]
fn data_is_retained() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let expected = initial_tree.clone();
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(expected, zipper.to_tree());
}

#[test]
fn left_right_and_value() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(Option::Some(3), zipper.left().unwrap().right().unwrap().value());
}

#[test]
fn dead_end() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert!(zipper.left().unwrap().left().is_none());
}

#[test]
fn tree_from_deep_focus() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let expected = initial_tree.clone();
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(expected, zipper.left().unwrap().right().unwrap().to_tree());
}

#[test]
fn traversing_up_from_top() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert!(zipper.up().is_none());
}

#[test]
fn left_right_and_up() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(
        Option::Some(3),
        zipper
            .left()
            .unwrap()
            .up()
            .unwrap()
            .right()
            .unwrap()
            .up()
            .unwrap()
            .left()
            .unwrap()
            .right()
            .unwrap()
            .value()
    );
}

#[test]
fn test_ability_to_descend_multiple_levels_and_return() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(
        Option::Some(1), zipper.left().unwrap().right().unwrap().up().unwrap().up().unwrap().value()
    );
}

#[test]
fn set_value() {
    let initial_tree = BinaryTree::new(
        1,
        BinaryTree::new(2, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let expected = BinaryTree::new(
        1,
        BinaryTree::new(5, Option::None, BinaryTree::new(3, Option::None, Option::None)),
        BinaryTree::new(4, Option::None, Option::None)
    );
    let zipper = Zipper::from_tree(initial_tree);
    assert_eq!(expected, zipper.left().unwrap().set_value(5).to_tree());
}
