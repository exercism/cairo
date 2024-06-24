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
        let mut i = self.collection.len();
        while i != 0 {
            i -= 1;
            if !other.contains(self.collection[i]) {
                result = false;
                break;
            }
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

        let mut i = to_iterate.collection.len();
        while i != 0 {
            i -= 1;
            if to_compare.contains(to_iterate.collection[i]) {
                are_disjoint = false;
                break;
            }
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

        let mut i = to_iterate.collection.len();
        while i != 0 {
            i -= 1;
            if to_compare.contains(to_iterate.collection[i]) {
                collection.append(*to_iterate.collection[i]);
            }
        };

        CustomSetImpl::<T>::new(@collection)
    }

    #[must_use]
    fn union(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut collection: Array<T> = array![];

        let mut i = self.collection.len();
        while i != 0 {
            i -= 1;
            collection.append(*self.collection[i]);
        };
        println!("self appended");
        i = other.collection.len();
        while i != 0 {
            i -= 1;
            collection.append(*other.collection[i]);
        };
        println!("other appended");
        CustomSetImpl::<T>::new(@collection)
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut diff = CustomSetImpl::<T>::new(@array![]);

        let mut i = 0;
        while let Option::Some(val) = self
            .collection
            .get(i) {
                let unboxed = val.unbox();
                if !other.contains(unboxed) {
                    diff.add(unboxed.clone());
                }
                i += 1;
            };

        diff
    }
}


#[cfg(test)]
mod tests;
