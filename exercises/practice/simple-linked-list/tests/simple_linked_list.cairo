use simple_linked_list::{SimpleLinkedListTrait, SimpleLinkedList};

#[test]
fn new_list_is_empty() {
    let list = SimpleLinkedListTrait::<u32>::new();
    assert_eq!(list.len(), 0, "list's length must be 0");
}

#[test]
#[ignore]
fn push_increments_length() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    assert_eq!(list.len(), 1, "list's length must be 1");
    list.push(2);
    assert_eq!(list.len(), 2, "list's length must be 2");
}

#[test]
#[ignore]
fn pop_decrements_length() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    list.pop().unwrap();
    assert_eq!(list.len(), 1, "list's length must be 1");
    list.pop().unwrap();
    assert_eq!(list.len(), 0, "list's length must be 0");
}

#[test]
#[ignore]
fn pop_returns_head_element_and_removes_it() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    assert_eq!(list.pop(), Option::Some(2), "Element must be 2");
    assert_eq!(list.pop(), Option::Some(1), "Element must be 1");
    let none: Option<u32> = Option::None;
    assert_eq!(list.pop(), none, "No element should be contained in list");
}

#[test]
#[ignore]
fn peek_returns_reference_to_head_element_but_does_not_remove_it() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    let none: Option<@u32> = Option::None;
    assert_eq!(list.peek(), none, "No element should be contained in list");
    list.push(2);
    assert_eq!(list.peek(), Option::Some(@2), "Element must be 2");
    assert_eq!(list.peek(), Option::Some(@2), "Element must be still 2");
    list.push(3);
    assert_eq!(list.peek(), Option::Some(@3), "Head element is now 3");
    assert_eq!(list.pop(), Option::Some(3), "Element must be 3");
    assert_eq!(list.peek(), Option::Some(@2), "Head element is now 2");
    assert_eq!(list.pop(), Option::Some(2), "Element must be 2");
    assert_eq!(list.peek(), none, "No element should be contained in list");
}

#[test]
#[ignore]
fn reverse() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    list.push(3);
    let mut rev_list = list.rev();
    assert_eq!(rev_list.pop(), Option::Some(1));
    assert_eq!(rev_list.pop(), Option::Some(2));
    assert_eq!(rev_list.pop(), Option::Some(3));
    let none: Option<u32> = Option::None;
    assert_eq!(rev_list.pop(), none);
}

#[test]
#[ignore]
fn reverse_empty_list() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    let mut rev_list = list.rev();
    let none: Option<u32> = Option::None;
    assert_eq!(rev_list.pop(), none);
    assert_eq!(rev_list.len(), 0);
}

#[test]
#[ignore]
fn from_array() {
    let mut array: Array<u32> = array![1, 2, 3, 4];
    let mut list: SimpleLinkedList<u32> = array.into();
    assert_eq!(list.pop(), Option::Some(4));
    assert_eq!(list.pop(), Option::Some(3));
    assert_eq!(list.pop(), Option::Some(2));
    assert_eq!(list.pop(), Option::Some(1));
}

#[test]
#[ignore]
fn from_empty_array_is_empty_list() {
    let mut array: Array<u32> = array![];
    let mut list: SimpleLinkedList<u32> = array.into();
    let none: Option<u32> = Option::None;
    assert_eq!(list.pop(), none);
    assert_eq!(list.len(), 0);
}

#[test]
#[ignore]
fn into_array() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    list.push(3);
    list.push(4);
    let list_as_arr: Array<u32> = list.into();
    assert_eq!(array![1, 2, 3, 4], list_as_arr);
}

#[test]
#[ignore]
fn empty_list_into_empty_array() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    let list_as_arr: Array<u32> = list.into();
    assert_eq!(array![], list_as_arr);
}
