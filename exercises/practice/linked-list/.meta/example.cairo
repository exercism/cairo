struct DoublyLinkedList<T> {
    dict: Felt252Dict<Nullable<Node<T>>>,
    head: Option<felt252>,
    tail: Option<felt252>,
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
    data: T,
    next: Option<felt252>,
    previous: Option<felt252>
}

#[generate_trait]
impl DoublyLinkedListImpl<
    T, +Drop<T>, +Copy<T>, +PartialEq<T>, +Felt252DictValue<T>
> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        DoublyLinkedList {
            dict: Default::default(), head: Option::None, tail: Option::None, len: 0, next_index: 0
        }
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        *self.len
    }

    fn push(ref self: DoublyLinkedList<T>, data: T) {
        match self.tail {
            Option::None => {
                let node = NullableTrait::new(NodeTrait::new(data, Option::None, Option::None));
                self.dict.insert(self.next_index, node);
                self.tail = Option::Some(self.next_index);
                self.head = self.tail;
                self.len += 1;
                self.next_index += 1;
            },
            Option::Some(tail) => {
                let node = NullableTrait::new(
                    NodeTrait::new(data, Option::Some(tail), Option::None)
                );
                self.dict.insert(self.next_index, node);
                let prev_tail = self.dict.get(tail).deref();
                let prev_tail = Node { next: Option::Some(self.next_index), ..prev_tail };
                self.dict.insert(self.tail.unwrap(), NullableTrait::new(prev_tail));
                self.tail = prev_tail.next;
                self.len += 1;
                self.next_index += 1;
            },
        }
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let data = self.dict.get(self.head.unwrap()).deref().data;
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = Option::None;
                self.tail = Option::None;
                self._decrease_len();
                Option::Some(data)
            },
            _ => {
                // pop tail
                let popped_tail = self.dict.get(self.tail.unwrap()).deref();
                self.dict.insert(self.tail.unwrap(), Default::default());
                self.tail = popped_tail.previous;
                self._decrease_len();
                // remove new tail's next node
                let new_tail = self.dict.get(self.tail.unwrap()).deref();
                let new_tail = Node { next: Option::None, ..new_tail };
                self.dict.insert(self.tail.unwrap(), NullableTrait::new(new_tail));

                Option::Some(popped_tail.data)
            }
        }
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let data = self.dict.get(self.head.unwrap()).deref().data;
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = Option::None;
                self.tail = Option::None;
                self._decrease_len();
                Option::Some(data)
            },
            _ => {
                // pop head
                let shifted_head = self.dict.get(self.head.unwrap()).deref();
                self.dict.insert(self.head.unwrap(), Default::default());
                self.head = shifted_head.next;
                self._decrease_len();
                // remove new head's next node
                let new_head = self.dict.get(self.head.unwrap()).deref();
                let new_head = Node { previous: Option::None, ..new_head };
                self.dict.insert(self.head.unwrap(), NullableTrait::new(new_head));

                Option::Some(shifted_head.data)
            }
        }
    }

    fn unshift(ref self: DoublyLinkedList<T>, data: T) {
        match self.head {
            Option::None => {
                let node = NullableTrait::new(NodeTrait::new(data, Option::None, Option::None));
                self.dict.insert(self.next_index, node);
                self.head = Option::Some(self.next_index);
                self.tail = self.head;
                self.len += 1;
                self.next_index += 1;
            },
            Option::Some(head) => {
                let node = NullableTrait::new(
                    NodeTrait::new(data, Option::None, Option::Some(head))
                );
                self.dict.insert(self.next_index, node);
                let prev_head = self.dict.get(head).deref();
                let prev_head = Node { previous: Option::Some(self.next_index), ..prev_head };
                self.dict.insert(self.head.unwrap(), NullableTrait::new(prev_head));
                self.head = prev_head.previous;
                self.len += 1;
                self.next_index += 1;
            },
        }
    }

    fn delete(ref self: DoublyLinkedList<T>, data: T) {
        if self.head.is_none() {
            return;
        }

        let mut to_remove = self.head;
        while let Option::Some(to_remove_index) =
            to_remove {
                let node = self.dict.get(to_remove_index).deref();

                if node.data != data {
                    to_remove = node.next;
                    continue;
                }

                if let Option::Some(previous_index) = node.previous {
                    let previous = self.dict.get(previous_index).deref();
                    let previous = Node { next: node.next, ..previous };
                    self.dict.insert(previous_index, NullableTrait::new(previous));
                }
                if let Option::Some(next_index) = node.next {
                    let next = self.dict.get(next_index).deref();
                    let next = Node { previous: node.previous, ..next };
                    self.dict.insert(next_index, NullableTrait::new(next));
                }

                if to_remove_index == self.head.unwrap() {
                    self.head = node.next;
                }
                if to_remove_index == self.tail.unwrap() {
                    self.tail = node.previous;
                }

                self.dict.insert(to_remove_index, Default::default());
                self._decrease_len();
                break;
            };
    }

    fn _decrease_len(ref self: DoublyLinkedList<T>) {
        self.len -= 1;
        if self.len == 0 {
            self.next_index = 0;
        }
    }
}

#[generate_trait]
impl NodeImpl<T> of NodeTrait<T> {
    fn new(data: T, previous: Option<felt252>, next: Option<felt252>) -> Node<T> {
        Node { data, previous, next }
    }
}

#[cfg(test)]
mod tests;
