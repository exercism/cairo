#[derive(Drop, Debug)]
struct Set {}

#[generate_trait]
pub impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        // construct a new Set struct
        panic!("implement `new`")
    }
}

impl SetEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        // determine whether the two Sets are equal
        panic!("implement `eq`")
    }

    fn ne(lhs: @Set, rhs: @Set) -> bool {
        // determine whether the two Sets are NOT equal
        panic!("implement `ne`")
    }
}

pub fn anagrams_for(word: @ByteArray, candidates: @Set) -> Set {
    // construct a Set of words from the set of candidates that are anagrams of {word}
    panic!("implement `anagrams_for`")
}
