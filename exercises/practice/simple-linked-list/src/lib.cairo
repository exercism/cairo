#[derive(Drop, Copy)]
pub struct SimpleLinkedList<T> {}

#[generate_trait]
pub impl SimpleLinkedListImpl<T, +Drop<T>, +Copy<T>> of SimpleLinkedListTrait<T> {
    fn new() -> SimpleLinkedList<T> {
        // construct a new SimpleLinkedList struct
        panic!("implement `new`")
    }

    fn is_empty(self: @SimpleLinkedList<T>) -> bool {
        // determine whether the list is empty
        panic!("implement `is_empty`")
    }

    fn len(self: @SimpleLinkedList<T>) -> usize {
        // return the list's length
        panic!("implement `len`")
    }

    fn push(ref self: SimpleLinkedList<T>, element: T) {
        // add a new element to the start of the list
        panic!("implement `push`")
    }

    fn pop(ref self: SimpleLinkedList<T>) -> Option<T> {
        // remove the first element of the list and return it
        panic!("implement `pop`")
    }

    fn peek(self: @SimpleLinkedList<T>) -> Option<@T> {
        // return the first element of the list
        panic!("implement `peek`")
    }

    #[must_use]
    fn rev(self: SimpleLinkedList<T>) -> SimpleLinkedList<T> {
        // return the reversed list
        panic!("implement `rev`")
    }
}

impl ArrayIntoSimpleLinkedList<T, +Drop<T>, +Copy<T>> of Into<Array<T>, SimpleLinkedList<T>> {
    #[must_use]
    fn into(self: Array<T>) -> SimpleLinkedList<T> {
        // construct a list from the given array
        panic!("implement `into`")
    }
}

impl SimpleLinkedListIntoArray<T, +Drop<T>, +Copy<T>> of Into<SimpleLinkedList<T>, Array<T>> {
    #[must_use]
    fn into(self: SimpleLinkedList<T>) -> Array<T> {
        // construct an array from the given list
        panic!("implement `into`")
    }
}
