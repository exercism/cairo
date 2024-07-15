#[derive(Drop, Debug, PartialEq)]
enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

fn sublist<T, +PartialEq<T>>(a: @Array<T>, b: @Array<T>) -> Comparison {
    panic!()
}

#[cfg(test)]
mod tests;
