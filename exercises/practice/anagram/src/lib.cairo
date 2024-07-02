#[derive(Drop, Debug)]
struct Set {}

#[generate_trait]
impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        panic!()
    }
}

impl SetEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        panic!()
    }

    fn ne(lhs: @Set, rhs: @Set) -> bool {
        !(lhs == rhs)
    }
}

pub fn anagrams_for(word: @ByteArray, inputs: @Set) -> Set {
    panic!()
}

#[cfg(test)]
mod tests;
