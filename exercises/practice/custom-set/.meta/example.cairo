#[derive(Drop, Debug)]
struct CustomSet<T> {
    collection: Array<T>,
}

impl CustomSetEq<
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
    fn new(input: @Array<T>) -> CustomSet<T> {
        let mut set = CustomSet::<T> { collection: array![], };
        let mut i = 0;
        while let Option::Some(val) = input
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

    fn contains(self: @CustomSet<T>, element: @T) -> bool {
        let mut i = 0;
        while let Option::Some(value) = self
            .collection
            .get(i) {
                if value.unbox() == element {
                    break;
                }
                i += 1;
            };
        i != self.collection.len()
    }

    fn is_empty(self: @CustomSet<T>) -> bool {
        self.collection.is_empty()
    }

    fn is_subset(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        if self.collection.len() > other.collection.len() {
            return false;
        }
        let mut i = 0;
        while let Option::Some(value) = self
            .collection
            .get(i) {
                if !other.contains(value.unbox()) {
                    break;
                }
                i += 1;
            };
        i == self.collection.len()
    }

    fn is_disjoint(self: @CustomSet<T>, other: @CustomSet<T>) -> bool {
        // a more efficient way is to iterate the smaller set
        let mut to_iterate = self;
        let mut to_compare = other;
        if to_iterate.collection.len() > to_compare.collection.len() {
            to_iterate = other;
            to_compare = self;
        };

        let mut i = 0;
        while let Option::Some(value) = to_iterate
            .collection
            .get(i) {
                if to_compare.contains(value.unbox()) {
                    break;
                }
                i += 1;
            };

        i == to_iterate.collection.len()
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
        while let Option::Some(boxed) = to_iterate
            .collection
            .get(i) {
                let value = boxed.unbox();
                if to_compare.contains(value) {
                    collection.append(*value);
                }
                i += 1;
            };

        CustomSetImpl::<T>::new(@collection)
    }

    #[must_use]
    fn difference(self: @CustomSet<T>, other: @CustomSet<T>) -> CustomSet<T> {
        let mut collection: Array<T> = array![];
        let mut i = 0;
        while let Option::Some(value) = self
            .collection
            .get(i) {
                let unboxed = value.unbox();
                if !other.contains(unboxed) {
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
        while let Option::Some(value) = self
            .collection
            .get(i) {
                collection.append(*value.unbox());
                i += 1;
            };
        let mut i = 0;
        while let Option::Some(value) = other
            .collection
            .get(i) {
                collection.append(*value.unbox());
                i += 1;
            };
        CustomSetImpl::<T>::new(@collection)
    }
}

