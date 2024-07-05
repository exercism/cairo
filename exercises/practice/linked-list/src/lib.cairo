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
        match self.tail {
            Option::None => {
                let node = BoxTrait::new(NodeTrait::new(data, Option::None, Option::None));
                self.tail = Option::Some(node);
                self.head = self.tail;
                self.len += 1;
            },
            Option::Some(tail) => {
                let node = BoxTrait::new(NodeTrait::new(data, Option::None, Option::Some(tail)));
                let mut tail = tail.unbox();
                tail.next = Option::Some(node);
                self.tail = tail.next;
                self.len += 1;
            },
        }
    }

    fn pop(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let data = self.head.unwrap().unbox().data;
                self.head = Option::None;
                self.tail = Option::None;
                self.len = 0;
                Option::Some(data)
            },
            _ => {
                let popped_tail = self.tail.unwrap().unbox();
                self.tail = popped_tail.previous;
                let mut new_tail = self.tail.unwrap().unbox();
                new_tail.next = Option::None;
                self.len -= 1;
                Option::Some(popped_tail.data)
            }
        }
    }

    fn shift(ref self: DoublyLinkedList<T>) -> Option<T> {
        match self.len {
            0 => Option::None,
            1 => {
                let data = self.head.unwrap().unbox().data;
                self.head = Option::None;
                self.tail = Option::None;
                self.len = 0;
                Option::Some(data)
            },
            _ => {
                let shifted_head = self.head.unwrap().unbox();
                self.head = shifted_head.next;
                let mut new_head = self.head.unwrap().unbox();
                new_head.previous = Option::None;
                self.len -= 1;
                Option::Some(shifted_head.data)
            }
        }
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
