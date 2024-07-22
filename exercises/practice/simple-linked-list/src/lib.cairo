#[derive(Drop, Copy)]
pub struct SimpleLinkedList<T> {}

#[generate_trait]
pub impl SimpleLinkedListImpl<T, +Drop<T>, +Copy<T>> of SimpleLinkedListTrait<T> {
    fn new() -> SimpleLinkedList<T> {
        panic!()
    }

    fn is_empty(self: @SimpleLinkedList<T>) -> bool {
        panic!()
    }

    fn len(self: @SimpleLinkedList<T>) -> usize {
        panic!()
    }

    fn push(ref self: SimpleLinkedList<T>, element: T) {
        panic!()
    }

    fn pop(ref self: SimpleLinkedList<T>) -> Option<T> {
        panic!()
    }

    fn peek(self: @SimpleLinkedList<T>) -> Option<@T> {
        panic!()
    }

    #[must_use]
    fn rev(self: SimpleLinkedList<T>) -> SimpleLinkedList<T> {
        panic!()
    }
}

impl ArrayIntoSimpleLinkedList<T, +Drop<T>, +Copy<T>> of Into<Array<T>, SimpleLinkedList<T>> {
    #[must_use]
    fn into(self: Array<T>) -> SimpleLinkedList<T> {
        panic!()
    }
}

impl SimpleLinkedListIntoArray<T, +Drop<T>, +Copy<T>> of Into<SimpleLinkedList<T>, Array<T>> {
    #[must_use]
    fn into(self: SimpleLinkedList<T>) -> Array<T> {
        panic!()
    }
}
