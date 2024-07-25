#[derive(Drop, Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T, +PartialEq<T>>(a: @Array<T>, b: @Array<T>) -> Comparison {
    panic!("implement `sublist`")
}
