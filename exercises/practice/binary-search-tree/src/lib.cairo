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
        panic!("implement `BinarySearchTreeTrait::new`")
    }

    fn value(self: @BinarySearchTree) -> Option<u32> {
        panic!("implement `BinarySearchTreeTrait::value`")
    }

    fn left(self: @BinarySearchTree) -> @BinarySearchTree {
        panic!("implement `BinarySearchTreeTrait::left`")
    }

    fn right(self: @BinarySearchTree) -> @BinarySearchTree {
        panic!("implement `BinarySearchTreeTrait::right`")
    }

    fn sorted_data(self: @BinarySearchTree) -> Span<u32> {
        panic!("implement `BinarySearchTreeTrait::sorted_data`")
    }
}
