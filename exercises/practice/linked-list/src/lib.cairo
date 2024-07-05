#[derive(Drop, Copy)]
struct DoublyLinkedList<T> {
    head: List<T>,
    tail: List<T>,
    len: usize,
}

type List<T> = Option<Box<Node<T>>>;

#[derive(Drop, Copy)]
struct Node<T> {
    data: T,
    next: List<T>,
    previous: List<T>
}

#[generate_trait]
impl DoublyLinkedListImpl<T, +Drop<T>, +Copy<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        DoublyLinkedList { head: Option::None, tail: Option::None, len: 0 }
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        *self.len
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!()
    }

    fn push(ref self: DoublyLinkedList<T>, element: T) {
        panic!()
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!()
    }

    fn unshift(ref self: DoublyLinkedList<T>, element: T) {
        panic!()
    }

    fn delete(ref self: DoublyLinkedList<T>, element: T) {
        panic!()
    }
}

#[cfg(test)]
mod tests;
