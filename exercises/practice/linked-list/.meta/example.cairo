use core::dict::Felt252Dict;

type Index = Option<felt252>;

struct DoublyLinkedList<T> {
    dict: Felt252Dict<Nullable<Node<T>>>,
    head: Index,
    tail: Index,
    len: usize,
    next_index: felt252,
}

impl DestructDoublyLinkedList<T, +Drop<T>, +Felt252DictValue<T>> of Destruct<DoublyLinkedList<T>> {
    fn destruct(self: DoublyLinkedList<T>) nopanic {
        self.dict.squash();
    }
}

#[derive(Drop, Copy)]
struct Node<T> {
    station: T,
    next: Index,
    previous: Index,
}

#[generate_trait]
pub impl DoublyLinkedListImpl<
    T, +Drop<T>, +Copy<T>, +PartialEq<T>, +Felt252DictValue<T>,
> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        DoublyLinkedList {
            dict: Default::default(), head: Option::None, tail: Option::None, len: 0, next_index: 0,
        }
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        *self.len
    }

    fn push(ref self: DoublyLinkedList<T>, station: T) {
        match self.tail {
            Option::None => {
                let node = NullableTrait::new(NodeTrait::new(station, Option::None, Option::None));
                self.dict.insert(self.next_index, node);
                self.tail = Option::Some(self.next_index);
                self.head = self.tail;
                self.len += 1;
                self.next_index += 1;
            },
            Option::Some(tail) => {
                let node = NullableTrait::new(NodeTrait::new(station, self.tail, Option::None));
                self.dict.insert(self.next_index, node);
                let old_tail = self.dict.get(tail).deref();
                let updated_old_tail = Node { next: Option::Some(self.next_index), ..old_tail };
                self.dict.insert(tail, NullableTrait::new(updated_old_tail));
                self.tail = updated_old_tail.next;
                self.len += 1;
                self.next_index += 1;
            },
        }
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let station = self.dict.get(self.head.unwrap()).deref().station;
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = Option::None;
                self.tail = Option::None;
                self.len -= 1;
                Option::Some(station)
            },
            _ => {
                // pop tail
                let popped_tail = self.dict.get(self.tail.unwrap()).deref();
                self.dict.insert(self.tail.unwrap(), Default::default());
                self.tail = popped_tail.previous;
                self.len -= 1;
                // remove new tail's next node
                let new_tail = self.dict.get(self.tail.unwrap()).deref();
                let new_tail = Node { next: Option::None, ..new_tail };
                self.dict.insert(self.tail.unwrap(), NullableTrait::new(new_tail));

                Option::Some(popped_tail.station)
            },
        }
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let station = self.dict.get(self.head.unwrap()).deref().station;
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = Option::None;
                self.tail = Option::None;
                self.len -= 1;
                Option::Some(station)
            },
            _ => {
                // pop head
                let shifted_head = self.dict.get(self.head.unwrap()).deref();
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = shifted_head.next;
                self.len -= 1;
                // remove new head's previous node
                let new_head = self.dict.get(self.head.unwrap()).deref();
                let new_head = Node { previous: Option::None, ..new_head };
                self.dict.insert(self.head.unwrap(), NullableTrait::new(new_head));

                Option::Some(shifted_head.station)
            },
        }
    }

    fn unshift(ref self: DoublyLinkedList<T>, station: T) {
        match self.head {
            Option::None => {
                let node = NullableTrait::new(NodeTrait::new(station, Option::None, Option::None));
                self.dict.insert(self.next_index, node);
                self.head = Option::Some(self.next_index);
                self.tail = self.head;
                self.len += 1;
                self.next_index += 1;
            },
            Option::Some(head) => {
                let node = NullableTrait::new(NodeTrait::new(station, Option::None, self.head));
                self.dict.insert(self.next_index, node);
                let old_head = self.dict.get(head).deref();
                let updated_old_head = Node { previous: Option::Some(self.next_index), ..old_head };
                self.dict.insert(head, NullableTrait::new(updated_old_head));
                self.head = updated_old_head.previous;
                self.len += 1;
                self.next_index += 1;
            },
        }
    }

    fn delete(ref self: DoublyLinkedList<T>, station: T) {
        if self.head.is_none() {
            return;
        }

        let mut to_remove = self.head;
        while let Option::Some(to_remove_index) = to_remove {
            let node = self.dict.get(to_remove_index).deref();

            if node.station != station {
                to_remove = node.next;
                continue;
            }

            if let Option::Some(previous_index) = node.previous {
                let previous = self.dict.get(previous_index).deref();
                let previous = Node { next: node.next, ..previous };
                self.dict.insert(previous_index, NullableTrait::new(previous));
            } else {
                // no previous node means head needs to be deleted
                self.head = node.next;
            }
            if let Option::Some(next_index) = node.next {
                let next = self.dict.get(next_index).deref();
                let next = Node { previous: node.previous, ..next };
                self.dict.insert(next_index, NullableTrait::new(next));
            } else {
                // no next node means tail needs to be deleted
                self.tail = node.previous;
            }

            self.dict.insert(to_remove_index, Default::default());
            self.len -= 1;
            break;
        };
    }
}

#[generate_trait]
impl NodeImpl<T> of NodeTrait<T> {
    fn new(station: T, previous: Index, next: Index) -> Node<T> {
        Node { station, previous, next }
    }
}
