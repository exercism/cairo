use core::array::ArrayTrait;
use core::box::BoxTrait;

#[derive(Drop)]
pub struct CustomSet<T> {
    collection: Array<T>,
}

pub impl CustomSetEq<T, +Copy<T>, +Drop<T>, +PartialEq<T>> of PartialEq<CustomSet<T>> {
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
pub impl CustomSetImpl<T, +Copy<T>, +Drop<T>, +PartialEq<T>> of CustomSetTrait<T> {
    fn new(inputs: @Array<T>) -> CustomSet<T> {
        let mut s = CustomSet::<T> { collection: array![], };
        let mut i = 0;
        while let Option::Some(val) = inputs.get(i) {
            let unboxed = val.unbox();
            s.add(*unboxed);
        };
        s
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
            .get(0) {
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
        let mut are_disjoint = false;

        let mut i = self.collection.len();
        let mut to_iterate = self;
        let mut to_compare = other;
        if i > other.collection.len() {
            i = other.collection.len();
            to_iterate = other;
            to_compare = self;
        };

        while i != 0 {
            i -= 1;
            if to_compare.contains(to_iterate.collection[i]) {
                are_disjoint = true;
                break;
            }
        };

        are_disjoint
    }
//     #[must_use]
//     pub fn intersection(&self, other: &Self) -> CustomSet<T> {
//         CustomSet::new(
//             &self
//                 .collection
//                 .iter()
//                 .filter(|c| other.contains(c))
//                 .cloned()
//                 .collect::<Vec<_>>(),
//         )
//     }

//     #[must_use]
//     pub fn union(&self, other: &Self) -> CustomSet<T> {
//         CustomSet::new(
//             &self
//                 .collection
//                 .iter()
//                 .chain(other.collection.iter())
//                 .cloned()
//                 .collect::<Vec<_>>(),
//         )
//     }

//     #[must_use]
//     pub fn difference(&self, other: &Self) -> CustomSet<T> {
//         CustomSet::new(
//             &self
//                 .collection
//                 .iter()
//                 .filter(|c| !other.contains(c))
//                 .cloned()
//                 .collect::<Vec<_>>(),
//         )
//     }
}


#[cfg(test)]
mod tests;
