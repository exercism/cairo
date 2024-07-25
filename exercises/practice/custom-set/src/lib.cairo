#[derive(Drop, Debug)]
struct CustomSet<T> {}

impl CustomSetEq<
    T, +Copy<T>, +Drop<T>, +PartialEq<T>, +core::fmt::Display<T>
> of PartialEq<CustomSet<T>> {
    fn eq(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        // determine whether the two CustomSets are equal
        panic!("implement `eq`")
    }

    fn ne(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        // determine whether the two CustomSets are NOT equal
        panic!("implement `ne`")
    }
}

#[generate_trait]
pub impl CustomSetImpl<
    T, +Copy<T>, +Drop<T>, +core::fmt::Display<T>, +PartialEq<T>
> of CustomSetTrait<T> {
    fn new(input: @Array<T>) -> CustomSet<T> {
        // construct a new CustomSet struct
        panic!("implement `new`")
    }

    fn add(ref self: CustomSet<T>, element: T) {
        // add {element} to the CustomSet
        panic!("implement `add`")
    }

    fn contains(self: @CustomSet<T>, element: @T) -> bool {
        // determine whether the CustomSet contains {element}
        panic!("implement `contains`")
    }

    fn is_subset(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        // determine whether {self} is a subset of {other}
        panic!("implement `is_subset`")
    }

    fn is_empty(self: @CustomSet<T>) -> bool {
        // determine whether {self} is empty
        panic!("implement `is_empty`")
    }

    fn is_disjoint(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        // determine whether {self} and {other} have no elements in common
        panic!("implement `is_disjoint`")
    }

    #[must_use]
    fn intersection(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains only those elements from {self} that
        // are also contained in {other}
        panic!("implement `intersection`")
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains only those elements from {self} that
        // are NOT contained in {other}
        panic!("implement `difference`")
    }

    #[must_use]
    fn union(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        // construct a CustomSet that contains all of the elements from both {self} AND {other}
        panic!("implement `union`")
    }
}
