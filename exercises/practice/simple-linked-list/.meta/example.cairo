#[derive(Drop)]
pub struct SimpleLinkedList<T> {
    head: List<T>,
    len: usize,
}

type List<T> = Option<Box<Node<T>>>;

struct Node<T> {
    data: T,
    next: List<T>,
}

impl NodeDrop<T, +Drop<T>> of Drop<Node<T>>; 
impl NodeCopy<T, +Copy<T>> of Copy<Node<T>>; 

#[generate_trait]
pub impl SimpleLinkedListImpl<T, +Drop<T>, +Copy<T>> of SimpleLinkedListTrait<T> {
    fn new() -> SimpleLinkedList<T> {
        SimpleLinkedList { head: Option::None, len: 0 }
    }

    fn is_empty(self: @SimpleLinkedList<T>) -> bool {
        *self.len == 0
    }

    fn len(self: @SimpleLinkedList<T>) -> usize {
        *self.len
    }

    fn push(ref self: SimpleLinkedList<T>, element: T) {
        let node = BoxTrait::new(NodeTrait::new(element, self.head));
        self.head = Option::Some(node);
        self.len += 1;
    }

    fn pop(ref self: SimpleLinkedList<T>) -> Option<T> {
        match self.head {
            Option::None => Option::None,
            Option::Some(node) => {
                self.len -= 1;
                let node = node.unbox();
                self.head = node.next;
                Option::Some(node.data)
            },
        }
    }

    fn peek(self: @SimpleLinkedList<T>) -> Option<@T> {
        match *self.head {
            Option::None => Option::None,
            Option::Some(node) => Option::Some(@node.unbox().data),
        }
    }

    #[must_use]
    fn rev(self: SimpleLinkedList<T>) -> SimpleLinkedList<T> {
        let mut self = self;
        let mut rev_list = SimpleLinkedListTrait::new();
        while let Option::Some(data) = self.pop() {
            rev_list.push(data);
        }
        rev_list
    }
}

impl ArrayIntoSimpleLinkedList<T, +Drop<T>, +Copy<T>> of Into<Array<T>, SimpleLinkedList<T>> {
    #[must_use]
    fn into(self: Array<T>) -> SimpleLinkedList<T> {
        let mut self = self;
        let mut list = SimpleLinkedListTrait::new();
        while let Option::Some(data) = self.pop_front() {
            list.push(data);
        }
        list
    }
}

impl SimpleLinkedListIntoArray<T, +Drop<T>, +Copy<T>> of Into<SimpleLinkedList<T>, Array<T>> {
    #[must_use]
    fn into(self: SimpleLinkedList<T>) -> Array<T> {
        let mut reversed = self.rev();
        let mut arr: Array<T> = array![];
        while let Option::Some(data) = reversed.pop() {
            arr.append(data);
        }
        arr
    }
}

#[generate_trait]
impl NodeImpl<T> of NodeTrait<T> {
    fn new(element: T, next: List<T>) -> Node<T> {
        Node { data: element, next }
    }
}
