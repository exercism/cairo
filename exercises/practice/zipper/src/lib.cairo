pub type BinaryTree = Option<Box<Node>>;

#[derive(Drop, Debug, PartialEq, Copy)]
pub struct Node {
    value: u32,
    left: BinaryTree,
    right: BinaryTree,
}

pub impl BinaryTreePartialEq of PartialEq<Option<Box<Node>>> {
    fn eq(lhs: @Option<Box<Node>>, rhs: @Option<Box<Node>>) -> bool {
        match (lhs, rhs) {
            (Option::Some(lhs), Option::Some(rhs)) => (*lhs).unbox() == (*rhs).unbox(),
            (Option::None, Option::None) => true,
            _ => false
        }
    }
}

impl NodeIntoBinaryTree of Into<Node, BinaryTree> {
    fn into(self: Node) -> BinaryTree {
        Option::Some(BoxTrait::new(self))
    }
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn with_value(self: Node, right: BinaryTree) -> Node {
        Node { right, ..self }
    }

    fn with_left(self: Node, left: BinaryTree) -> Node {
        Node { left, ..self }
    }

    fn with_right(self: Node, right: BinaryTree) -> Node {
        Node { right, ..self }
    }
}

#[generate_trait]
pub impl BinaryTreeImpl of BinaryTreeTrait {
    fn new(value: u32, left: BinaryTree, right: BinaryTree) -> BinaryTree {
        Option::Some(BoxTrait::new(Node { value, left, right }))
    }

    fn set_value(self: BinaryTree, value: u32) -> BinaryTree {
        Self::new(value, *self.left(), *self.right())
    }

    // TODO: return snapshot of value
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

#[derive(Drop, Copy)]
enum Path {
    Left,
    Right
}

#[derive(Drop, Copy)]
struct Ancestor {
    path: Path,
    node: Node
}

#[derive(Drop, Copy)]
struct Zipper {
    tree: BinaryTree,
    ancestors: Span<Ancestor>
}

#[generate_trait]
pub impl ZipperImpl of ZipperTrait {
    fn from_tree(tree: BinaryTree) -> Zipper {
        Self::init(tree, array![].span())
    }

    fn init(tree: BinaryTree, ancestors: Span<Ancestor>) -> Zipper {
        Zipper { tree, ancestors }
    }

    fn rebuild_tree(tree: BinaryTree, ancestors: Span<Ancestor>) -> BinaryTree {
        let mut ancestors = ancestors;
        if let Option::Some(last) = ancestors.pop_back() {
            Self::rebuild_tree(Self::from_ancestor(tree, *last), ancestors)
        } else {
            tree
        }
    }

    fn to_tree(self: Zipper) -> BinaryTree {
        Self::rebuild_tree(self.tree, self.ancestors)
    }

    fn value(self: @Zipper) -> Option<u32> {
        self.tree.value()
    }

    fn left(self: Zipper) -> Option<Zipper> {
        Option::Some(
            Self::init(
                Option::Some((*self.tree.left())?),
                self
                    .ancestors
                    .append(Ancestor { path: Path::Left, node: self.tree.unwrap().unbox() })
            )
        )
    }

    fn right(self: Zipper) -> Option<Zipper> {
        Option::Some(
            Self::init(
                Option::Some((*self.tree.right())?),
                self
                    .ancestors
                    .append(Ancestor { path: Path::Right, node: self.tree.unwrap().unbox() })
            )
        )
    }

    fn up(self: Zipper) -> Option<Zipper> {
        let mut ancestors = self.ancestors;
        let ancestor = *ancestors.pop_back()?;
        Option::Some(Self::init(Self::from_ancestor(self.tree, ancestor), ancestors))
    }

    fn from_ancestor(tree: BinaryTree, ancestor: Ancestor) -> BinaryTree {
        match ancestor.path {
            Path::Left => ancestor.node.with_left(tree).into(),
            Path::Right => ancestor.node.with_right(tree).into(),
        }
    }

    fn set_value(self: Zipper, value: u32) -> Zipper {
        Self::init(
            BinaryTreeTrait::new(value, *self.tree.left(), *self.tree.right()), self.ancestors
        )
    }

    fn set_left(self: Zipper, left: BinaryTree) -> Zipper {
        Self::init(
            BinaryTreeTrait::new(self.tree.value().unwrap(), left, *self.tree.right()),
            self.ancestors
        )
    }

    fn set_right(self: Zipper, right: BinaryTree) -> Zipper {
        Self::init(
            BinaryTreeTrait::new(self.tree.value().unwrap(), *self.tree.left(), right),
            self.ancestors
        )
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
