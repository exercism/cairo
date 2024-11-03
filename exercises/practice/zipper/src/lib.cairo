pub type BinaryTree = Option<Box<BinaryTreeNode>>;

#[derive(Drop, Debug, PartialEq, Copy)]
pub struct BinaryTreeNode {
    value: u32,
    left: BinaryTree,
    right: BinaryTree,
}

pub impl BinaryTreePartialEq of PartialEq<Option<Box<BinaryTreeNode>>> {
    fn eq(lhs: @Option<Box<BinaryTreeNode>>, rhs: @Option<Box<BinaryTreeNode>>) -> bool {
        match (lhs, rhs) {
            (Option::Some(lhs), Option::Some(rhs)) => (*lhs).unbox() == (*rhs).unbox(),
            (Option::None, Option::None) => true,
            _ => false
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
            Option::Some(bst) => bst.left
        }
    }

    fn right(self: @BinaryTree) -> @BinaryTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.right
        }
    }
}

#[derive(Drop, Copy, Debug, PartialEq)]
enum Path {
    Left,
    Right
}

#[derive(Drop, Copy, Debug, PartialEq)]
struct Ancestor {
    path: Path,
    node: BinaryTreeNode
}

#[derive(Drop, Copy, Debug, PartialEq)]
struct Zipper {
    node: BinaryTreeNode,
    ancestors: Span<Ancestor>
}

#[generate_trait]
pub impl ZipperImpl of ZipperTrait {
    fn new(tree: BinaryTree, ancestors: Span<Ancestor>) -> Option<Zipper> {
        Option::Some(Zipper { node: tree?.unbox(), ancestors })
    }

    fn from_tree(tree: BinaryTree) -> Option<Zipper> {
        Self::new(tree, array![].span())
    }

    fn to_tree(self: Zipper) -> BinaryTree {
        rebuild_tree(self.node.into(), self.ancestors)
    }

    fn value(self: @Zipper) -> @u32 {
        self.node.value
    }

    fn left(self: Zipper) -> Option<Zipper> {
        Self::new(
            self.node.left, self.ancestors.append(Ancestor { path: Path::Left, node: self.node })
        )
    }

    fn right(self: Zipper) -> Option<Zipper> {
        Self::new(
            self.node.right, self.ancestors.append(Ancestor { path: Path::Right, node: self.node })
        )
    }

    fn up(self: Zipper) -> Option<Zipper> {
        let mut ancestors = self.ancestors;
        let ancestor = *ancestors.pop_back()?;
        Self::new(from_ancestor(self.node.into(), ancestor), ancestors)
    }

    fn set_value(self: Zipper, value: u32) -> Zipper {
        Self::new(self.node.set_value(value).into(), self.ancestors).unwrap()
    }

    fn set_left(self: Zipper, left: BinaryTree) -> Zipper {
        Self::new(self.node.set_left(left).into(), self.ancestors).unwrap()
    }

    fn set_right(self: Zipper, right: BinaryTree) -> Zipper {
        Self::new(self.node.set_right(right).into(), self.ancestors).unwrap()
    }
}

fn from_ancestor(tree: BinaryTree, ancestor: Ancestor) -> BinaryTree {
    match ancestor.path {
        Path::Left => ancestor.node.set_left(tree).into(),
        Path::Right => ancestor.node.set_right(tree).into(),
    }
}

fn rebuild_tree(tree: BinaryTree, ancestors: Span<Ancestor>) -> BinaryTree {
    let mut ancestors = ancestors;
    if let Option::Some(last) = ancestors.pop_back() {
        rebuild_tree(from_ancestor(tree, *last), ancestors)
    } else {
        tree
    }
}

#[generate_trait]
impl SpanAppendImpl of SpanAppendTrait {
    fn append<T, +Drop<T>, +Clone<T>>(self: Span<T>, value: T) -> Span<T> {
        let mut arr: Array<T> = self.into();
        arr.append(value);
        arr.span()
    }
}
