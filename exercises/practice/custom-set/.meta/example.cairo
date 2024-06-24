use core::clone::Clone;
use core::array::ArrayTrait;
use core::box::BoxTrait;

#[derive(Drop, Debug)]
pub struct CustomSet<T> {
    pub collection: Array<T>,
}

pub impl CustomSetEq<
    T, +Copy<T>, +Drop<T>, +PartialEq<T>, +core::fmt::Display<T>
> of PartialEq<CustomSet<T>> {
    fn eq(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        if lhs.collection.len() != rhs.collection.len() {
            return false;
        }
        lhs.is_subset(rhs) && rhs.is_subset(lhs)
    }

    fn ne(lhs: @CustomSet<T>, rhs: @CustomSet<T>) -> bool {
        !(lhs == rhs)
    }
}

#[generate_trait]
pub impl CustomSetImpl<
    T, +Copy<T>, +Drop<T>, +core::fmt::Display<T>, +PartialEq<T>
> of CustomSetTrait<T> {
    fn new(inputs: @Array<T>) -> CustomSet<T> {
        let mut set = CustomSet::<T> { collection: array![], };
        let mut i = 0;
        while let Option::Some(val) = inputs
            .get(i) {
                let unboxed = val.unbox();
                set.add(unboxed.clone());
                i += 1;
            };
        set
    }

    fn add(ref self: CustomSet<T>, element: T) {
        if !self.contains(@element) {
            self.collection.append(element)
        }
    }

    fn contains(self: @CustomSet<T>, other: @T) -> bool {
        let mut is_contained = false;
        let mut i = 0;
        while let Option::Some(boxed) = self
            .collection
            .get(i) {
                let val = boxed.unbox();
                if val == other {
                    is_contained = true;
                    break;
                }
                i += 1;
            };
        is_contained
    }

    fn is_empty(self: @CustomSet<T>) -> bool {
        self.collection.is_empty()
    }

    fn is_subset(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        if self.collection.len() > other.collection.len() {
            return false;
        }
        let mut result = true;
        let mut i = 0;
        while let Option::Some(val) = self
            .collection
            .get(i) {
                if !other.contains(val.unbox()) {
                    result = false;
                    break;
                }
                i += 1;
            };
        result
    }

    fn is_disjoint(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        let mut are_disjoint = true;

        // a more efficient way is to iterate the smaller set
        let mut to_iterate = self;
        let mut to_compare = other;
        if to_iterate.collection.len() > to_compare.collection.len() {
            to_iterate = other;
            to_compare = self;
        };

        let mut i = 0;
        while let Option::Some(val) = to_iterate
            .collection
            .get(i) {
                if to_compare.contains(val.unbox()) {
                    are_disjoint = false;
                    break;
                }
                i += 1;
            };

        are_disjoint
    }

    #[must_use]
    fn intersection(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut collection: Array<T> = array![];

        // a more efficient way is to iterate the smaller set
        let mut to_iterate = self;
        let mut to_compare = other;
        if to_iterate.collection.len() > to_compare.collection.len() {
            to_iterate = other;
            to_compare = self;
        };

        let mut i = 0;
        while let Option::Some(val) = to_iterate
            .collection
            .get(i) {
                let unboxed = val.unbox();
                if to_compare.contains(unboxed) {
                    collection.append(*unboxed);
                }
                i += 1;
            };

        CustomSetImpl::<T>::new(@collection)
    }

    #[must_use]
    fn union(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut collection: Array<T> = array![];
        let mut i = 0;
        while let Option::Some(val) = self
            .collection
            .get(i) {
                collection.append(*val.unbox());
                i += 1;
            };
        i = 0;
        while let Option::Some(val) = other
            .collection
            .get(i) {
                collection.append(*val.unbox());
                i += 1;
            };
        CustomSetImpl::<T>::new(@collection)
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut collection: Array<T> = array![];
        let mut i = 0;
        while let Option::Some(val) = self
            .collection
            .get(i) {
                let unboxed = val.unbox();
                if !other.contains(unboxed) {
                    collection.append(unboxed.clone());
                }
                i += 1;
            };
        CustomSetImpl::<T>::new(@collection)
    }
}


#[cfg(test)]
mod tests;
