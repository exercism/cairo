type BinarySearchTree = Option<Box<Node>>;

#[derive(Drop, Copy)]
struct Node {
    value: u32,
    left: BinarySearchTree,
    right: BinarySearchTree,
}

#[generate_trait]
pub impl BinarySearchTreeImpl of BinarySearchTreeTrait {
    fn new(tree_data: Span<u32>) -> BinarySearchTree {
        let mut bts: BinarySearchTree = Default::default();
        for value in tree_data {
            bts = bts.add(*value);
        }
        bts
    }

    fn add(self: BinarySearchTree, value: u32) -> BinarySearchTree {
        match self {
            Option::None => Option::Some(
                BoxTrait::new(Node { value, left: Option::None, right: Option::None }),
            ),
            Option::Some(node) => {
                if value <= node.value {
                    Option::Some(
                        BoxTrait::new(
                            Node {
                                value: node.value, left: node.left.add(value), right: node.right,
                            },
                        ),
                    )
                } else {
                    Option::Some(
                        BoxTrait::new(
                            Node {
                                value: node.value, left: node.left, right: node.right.add(value),
                            },
                        ),
                    )
                }
            },
        }
    }

    fn value(self: @BinarySearchTree) -> Option<u32> {
        Option::Some((*self)?.value)
    }

    fn left(self: @BinarySearchTree) -> @BinarySearchTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.left,
        }
    }

    fn right(self: @BinarySearchTree) -> @BinarySearchTree {
        @match self {
            Option::None => Option::None,
            Option::Some(bst) => bst.right,
        }
    }

    fn sorted_data(self: @BinarySearchTree) -> Span<u32> {
        let mut res = array![];
        if let Option::Some(node) = self {
            res.append_span(node.left.sorted_data());
            res.append(node.value);
            res.append_span(node.right.sorted_data());
        }
        res.span()
    }
}
