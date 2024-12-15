type BinaryTree = Option<Box<BinaryTreeNode>>;

#[derive(Drop, Debug, PartialEq, Copy)]
struct BinaryTreeNode {
    value: u32,
    left: BinaryTree,
    right: BinaryTree,
}

pub impl OptionalBinaryTreeNodePartialEq of PartialEq<Option<Box<BinaryTreeNode>>> {
    fn eq(lhs: @Option<Box<BinaryTreeNode>>, rhs: @Option<Box<BinaryTreeNode>>) -> bool {
        match (lhs, rhs) {
            (Option::Some(lhs), Option::Some(rhs)) => (*lhs).unbox() == (*rhs).unbox(),
            (Option::None, Option::None) => true,
            _ => false,
        }
    }
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn set_value(self: BinaryTreeNode, value: u32) -> BinaryTreeNode {
        BinaryTreeNode { value, ..self }
    }

    fn set_left(self: BinaryTreeNode, left: BinaryTree) -> BinaryTreeNode {
        BinaryTreeNode { left, ..self }
    }

    fn set_right(self: BinaryTreeNode, right: BinaryTree) -> BinaryTreeNode {
        BinaryTreeNode { right, ..self }
    }
}

impl NodeIntoBinaryTree of Into<BinaryTreeNode, BinaryTree> {
    fn into(self: BinaryTreeNode) -> BinaryTree {
        Option::Some(BoxTrait::new(self))
    }
}

#[generate_trait]
pub impl BinaryTreeImpl of BinaryTreeTrait {
    fn empty() -> BinaryTree {
        Option::None
    }

    fn new(value: u32, left: BinaryTree, right: BinaryTree) -> BinaryTree {
        Option::Some(BoxTrait::new(BinaryTreeNode { value, left, right }))
    }

    fn leaf(value: u32) -> BinaryTree {
        Self::new(value, Self::empty(), Self::empty())
    }

    fn set_value(self: BinaryTree, value: u32) -> BinaryTree {
        Self::new(value, *self.left(), *self.right())
    }

    fn value(self: @BinaryTree) -> Option<u32> {
        Option::Some((*self)?.value)
    }

    fn left(self: @BinaryTree) -> @BinaryTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.left,
        }
    }

    fn right(self: @BinaryTree) -> @BinaryTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.right,
        }
    }
}

#[derive(Drop, Debug, PartialEq)]
struct Zipper {}

#[generate_trait]
pub impl ZipperImpl of ZipperTrait {
    fn from_tree(tree: BinaryTree) -> Option<Zipper> {
        panic!("implement `ZipperTrait::from_tree`")
    }

    fn to_tree(self: Zipper) -> BinaryTree {
        panic!("implement `ZipperTrait::to_tree`")
    }

    fn value(self: @Zipper) -> @u32 {
        panic!("implement `ZipperTrait::value`")
    }

    fn left(self: Zipper) -> Option<Zipper> {
        panic!("implement `ZipperTrait::left`")
    }

    fn right(self: Zipper) -> Option<Zipper> {
        panic!("implement `ZipperTrait::right`")
    }

    fn up(self: Zipper) -> Option<Zipper> {
        panic!("implement `ZipperTrait::up`")
    }

    fn set_value(self: Zipper, value: u32) -> Zipper {
        panic!("implement `ZipperTrait::set_value`")
    }

    fn set_left(self: Zipper, left: BinaryTree) -> Zipper {
        panic!("implement `ZipperTrait::set_left`")
    }

    fn set_right(self: Zipper, right: BinaryTree) -> Zipper {
        panic!("implement `ZipperTrait::set_right`")
    }
}
