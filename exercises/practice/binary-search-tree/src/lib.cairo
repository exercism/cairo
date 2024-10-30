use core::dict::Felt252Dict;

pub type SubtreeIndex = Option<felt252>;

#[derive(Drop, Copy, PartialEq, Debug, Default)]
pub struct Node {
    pub elem: u32,
    pub left: SubtreeIndex,
    pub right: SubtreeIndex,
}

#[derive(Default)]
pub struct Bts {
    pub elements: Felt252Dict<Nullable<Node>>,
    pub count: felt252,
}

impl BtsDestruct of Destruct<Bts> {
    fn destruct(self: Bts) nopanic {
        self.elements.squash();
    }
}

#[generate_trait]
pub impl BtsImpl of BtsTrait {
    fn new(tree_data: Span<u32>) -> Bts {
        panic!("implement `BtsTrait::new`")
    }

    fn sorted_data(ref self: Bts) -> Span<u32> {
        panic!("implement `BtsTrait::sorted_data`")
    }
}
