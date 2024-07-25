#[derive(Drop)]
struct DoublyLinkedList<T> {}

#[generate_trait]
pub impl DoublyLinkedListImpl<T, +Drop<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        panic!("implement `new`: constructs a new DoublyLinkedList struct")
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        panic!("implement `len`: returns the list's length")
    }

    fn push(ref self: DoublyLinkedList<T>, station: T) {
        panic!("implement `push`: adds a new element to the end of the list")
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!("implement `pop`: removes the last element in the list and returns it")
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!("implement `shift`: removes the first element in the list and returns it")
    }

    fn unshift(ref self: DoublyLinkedList<T>, station: T) {
        panic!("implement `unshift`: adds a new element to the beginning of the list")
    }

    fn delete(ref self: DoublyLinkedList<T>, station: T) {
        panic!("implement `delete`: removes the first occurrence of the specified station")
    }
}
