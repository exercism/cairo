use core::box::BoxTrait;
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

    fn push(ref self: DoublyLinkedList<T>, data: T) {
        match self.head {
            Option::None => {
                let node = BoxTrait::new(NodeTrait::new(data, Option::None, Option::None));
                self.head = Option::Some(node);
                self.len += 1;
            },
            Option::Some(head) => {
                match self.tail {
                    Option::None => {
                        let node = BoxTrait::new(
                            NodeTrait::new(data, Option::None, Option::Some(head))
                        );
                        let mut head = head.unbox();
                        head.next = Option::Some(node);
                        self.tail = head.next;
                        self.len += 1;
                    },
                    Option::Some(tail) => {
                        let node = BoxTrait::new(
                            NodeTrait::new(data, Option::None, Option::Some(tail))
                        );
                        let mut tail = tail.unbox();
                        tail.next = Option::Some(node);
                        self.tail = tail.next;
                        self.len += 1;
                    },
                }
            },
        }
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
    fn new(data: T, next: List<T>, previous: List<T>) -> Node<T> {
        Node { data, next, previous }
    }
}

#[cfg(test)]
mod tests;
