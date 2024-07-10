struct DoublyLinkedList<T> {
    dict: Felt252Dict<Nullable<Node<T>>>,
    head: Option<felt252>,
    tail: Option<felt252>,
    len: usize,
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
impl DoublyLinkedListImpl<T, +Drop<T>, +Felt252DictValue<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        DoublyLinkedList {
            dict: Default::default(), head: Option::None, tail: Option::None, len: 0
        }
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        *self.len
    }

    fn push(ref self: DoublyLinkedList<T>, data: T) {
        panic!()
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!()
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!()
    }

    fn unshift(ref self: DoublyLinkedList<T>, data: T) {
        panic!()
    }

    fn delete(ref self: DoublyLinkedList<T>, data: T) {
        panic!()
    }
}

#[generate_trait]
impl NodeImpl<T> of NodeTrait<T> {
    fn new(data: T, next: Option<felt252>, previous: Option<felt252>) -> Node<T> {
        Node { data, next, previous }
    }
}