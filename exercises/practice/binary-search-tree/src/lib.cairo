use core::dict::Felt252Dict;

pub type SubtreeIndex = Option<felt252>;

#[derive(Drop, Copy, PartialEq, Default)]
pub struct Node {
    pub elem: u32,
    pub left: SubtreeIndex,
    pub right: SubtreeIndex,
}

#[generate_trait]
impl NodeImpl of NodeTrait {
    fn new(elem: u32) -> Node {
        Node { elem, left: Option::None, right: Option::None }
    }
}

#[derive(Default)]
pub struct Bts {
    pub root: SubtreeIndex,
    pub elements: Felt252Dict<Nullable<Node>>,
    pub next_index: felt252,
}

impl BtsDestruct of Destruct<Bts> {
    fn destruct(self: Bts) nopanic {
        self.elements.squash();
    }
}

#[generate_trait]
pub impl BtsImpl of BtsTrait {
    fn new(tree_data: Span<u32>) -> Bts {
        let mut bts: Bts = Default::default();
        for elem in tree_data {
            bts.add(*elem);
        };
        bts
    }

    fn add(ref self: Bts, elem: u32) {
        match self.root {
            Option::None => self.root = Option::Some(self.next_index),
            Option::Some(root) => self._insert(root, elem)
        };
        self.elements.insert(self.next_index, NullableTrait::new(NodeTrait::new(elem)));
        self.next_index += 1;
    }

    fn flatten(ref self: Bts) -> Span<u32> {
        self._flatten_subtree(self.root)
    }
}

#[generate_trait]
impl BtsPrivateImpl of BtsPrivateTrait {
    fn _insert(ref self: Bts, subtree_index: felt252, elem: u32) {
        let mut node = self.elements.get(subtree_index).deref();

        if elem <= node.elem {
            if let Option::Some(left) = node.left {
                self._insert(left, elem)
            } else {
                node.left = Option::Some(self.next_index);
                self.elements.insert(subtree_index, NullableTrait::new(node));
            }
        } else {
            if let Option::Some(right) = node.right {
                self._insert(right, elem)
            } else {
                node.right = Option::Some(self.next_index);
                self.elements.insert(subtree_index, NullableTrait::new(node));
            }
        }
    }

    fn _flatten_subtree(ref self: Bts, subtree_index: SubtreeIndex) -> Span<u32> {
        let mut res = array![];
        if let Option::Some(subtree_index) = subtree_index {
            let node = self.elements.get(subtree_index).deref();
            res.append_span(self._flatten_subtree(node.left));
            res.append(node.elem);
            res.append_span(self._flatten_subtree(node.right));
        }
        res.span()
    }
}
