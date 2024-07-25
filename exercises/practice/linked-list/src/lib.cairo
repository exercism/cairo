#[derive(Drop)]
struct DoublyLinkedList<T> {}

#[generate_trait]
pub impl DoublyLinkedListImpl<T, +Drop<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        // constructs a new DoublyLinkedList struct
        panic!("implement `new`")
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        // returns the list's length
        panic!("implement `len`")
    }

    fn push(ref self: DoublyLinkedList<T>, station: T) {
        // adds a new element to the end of the list
        panic!("implement `push`")
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        // removes the last element in the list and returns it
        panic!("implement `pop`")
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        // removes the first element in the list and returns it
        panic!("implement `shift`")
    }

    fn unshift(ref self: DoublyLinkedList<T>, station: T) {
        // adds a new element to the beginning of the list
        panic!("implement `unshift`")
    }

    fn delete(ref self: DoublyLinkedList<T>, station: T) {
        // removes the first occurrence of the specified station
        panic!("implement `delete`")
    }
}
