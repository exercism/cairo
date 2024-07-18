#[derive(Drop, Debug)]
struct Set {}

#[generate_trait]
pub impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        panic!()
    }
}

impl SetEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        panic!()
    }

    fn ne(lhs: @Set, rhs: @Set) -> bool {
        panic!()
    }
}

pub fn anagrams_for(word: @ByteArray, inputs: @Set) -> Set {
    panic!()
}
