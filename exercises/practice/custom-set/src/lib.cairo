#[derive(Drop, Debug)]
pub struct CustomSet<T> {}

pub impl CustomSetEq<
    T, +Copy<T>, +Drop<T>, +PartialEq<T>, +core::fmt::Display<T>
> of PartialEq<CustomSet<T>> {
    fn eq(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        panic!()
    }

    fn ne(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        panic!()
    }
}

#[generate_trait]
pub impl CustomSetImpl<
    T, +Copy<T>, +Drop<T>, +core::fmt::Display<T>, +PartialEq<T>
> of CustomSetTrait<T> {
    fn new(_input: @Array<T>) -> CustomSet<T> {
        panic!()
    }

    fn contains(self: @CustomSet<T>, element: @T) -> bool {
        panic!()
    }

    fn add(ref self: CustomSet<T>, element: T) {
        panic!();
    }

    fn is_subset(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        panic!()
    }

    fn is_empty(self: @CustomSet<T>) -> bool {
        panic!()
    }

    fn is_disjoint(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        panic!()
    }

    #[must_use]
    fn intersection(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        panic!()
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        panic!()
    }

    #[must_use]
    fn union(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        panic!()
    }
}

#[cfg(test)]
mod tests;
