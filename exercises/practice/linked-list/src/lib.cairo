#[derive(Drop)]
struct DoublyLinkedList<T> {}

#[generate_trait]
impl DoublyLinkedListImpl<T, +Drop<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        panic!()
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        panic!()
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
