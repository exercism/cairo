#[derive(Drop)]
struct DoublyLinkedList<T> {}

#[generate_trait]
pub impl DoublyLinkedListImpl<T, +Drop<T>> of DoublyLinkedListTrait<T> {
    fn new() -> DoublyLinkedList<T> {
        panic!("implement 'new'")
    }

    fn len(self: @DoublyLinkedList<T>) -> usize {
        panic!("implement 'len'")
    }

    fn push(ref self: DoublyLinkedList<T>, data: T) {
        panic!("implement 'push'")
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!("implement 'pop'")
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        panic!("implement 'shift'")
    }

    fn unshift(ref self: DoublyLinkedList<T>, data: T) {
        panic!("implement 'unshift'")
    }

    fn delete(ref self: DoublyLinkedList<T>, data: T) {
        panic!("implement 'delete'")
    }
}
