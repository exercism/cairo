use zipper::{ZipperTrait as Zipper, BinaryTreeTrait as BinaryTree, OptionalBinaryTreeNodePartialEq};

#[test]
fn data_is_retained() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = initial_tree.clone();
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(expected, zipper.to_tree());
    Option::Some(())
}

#[test]
fn left_right_and_value() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(@3, zipper.left()?.right()?.value());
    Option::Some(())
}

#[test]
fn dead_end() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert!(zipper.left()?.left().is_none());
    Option::Some(())
}

#[test]
fn tree_from_deep_focus() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = initial_tree.clone();
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(expected, zipper.left()?.right()?.to_tree());
    Option::Some(())
}

#[test]
fn traversing_up_from_top() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert!(zipper.up().is_none());
    Option::Some(())
}

#[test]
fn left_right_and_up() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(@3, zipper.left()?.up()?.right()?.up()?.left()?.right()?.value());
    Option::Some(())
}

#[test]
fn test_ability_to_descend_multiple_levels_and_return() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(@1, zipper.left()?.right()?.up()?.up()?.value());
    Option::Some(())
}

#[test]
fn set_value() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(
        1, BinaryTree::new(5, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let zipper = Zipper::from_tree(initial_tree)?;
    assert_eq!(expected, zipper.left()?.set_value(5).to_tree());
    Option::Some(())
}

#[test]
fn set_value_after_traversing_up() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(
        1, BinaryTree::new(5, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );

    let zipper = Zipper::from_tree(initial_tree)?;

    assert_eq!(expected, zipper.left()?.right()?.up()?.set_value(5).to_tree());
    Option::Some(())
}

#[test]
fn set_left_with_leaf() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::leaf(5), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );

    let zipper = Zipper::from_tree(initial_tree)?;

    assert_eq!(expected, zipper.left()?.set_left(BinaryTree::leaf(5)).to_tree());
    Option::Some(())
}

#[test]
fn set_right_with_leaf() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(1, BinaryTree::leaf(2), BinaryTree::leaf(4));

    let zipper = Zipper::from_tree(initial_tree)?;

    assert_eq!(expected, zipper.left()?.set_right(BinaryTree::empty()).to_tree());
    Option::Some(())
}

#[test]
fn set_right_with_subtree() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(
        1,
        BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)),
        BinaryTree::new(6, BinaryTree::leaf(7), BinaryTree::leaf(8))
    );

    let zipper = Zipper::from_tree(initial_tree)?;

    assert_eq!(
        expected,
        zipper.set_right(BinaryTree::new(6, BinaryTree::leaf(7), BinaryTree::leaf(8))).to_tree()
    );
    Option::Some(())
}

#[test]
fn set_value_on_deep_focus() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(5)), BinaryTree::leaf(4)
    );

    let zipper = Zipper::from_tree(initial_tree)?;

    assert_eq!(expected, zipper.left()?.right()?.set_value(5).to_tree());
    Option::Some(())
}

#[test]
fn different_paths_to_same_zipper() -> Option<()> {
    let initial_tree = BinaryTree::new(
        1, BinaryTree::new(2, BinaryTree::empty(), BinaryTree::leaf(3)), BinaryTree::leaf(4)
    );
    let expected = Zipper::from_tree(initial_tree)?.right();
    let actual = Zipper::from_tree(initial_tree)?.left()?.up()?.right();

    assert_eq!(expected, actual);
    Option::Some(())
}
