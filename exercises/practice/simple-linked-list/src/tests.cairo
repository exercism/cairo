use core::option::OptionTrait;
use simple_linked_list::{SimpleLinkedListTrait, SimpleLinkedList};

#[test]
fn new_list_is_empty() {
    let list = SimpleLinkedListTrait::<u32>::new();
    assert_eq!(list.len(), 0, "list's length must be 0");
}

#[test]
fn push_increments_length() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    assert_eq!(list.len(), 1, "list's length must be 1");
    list.push(2);
    assert_eq!(list.len(), 2, "list's length must be 2");
}

#[test]
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
fn is_empty() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    assert!(list.is_empty(), "List wasn't empty on creation");
    let mut inserts = 0;
    while inserts < 100 {
        let mut i = 0;
        while i < inserts {
            list.push(i);
            assert!(
                !list.is_empty(), "List was empty after having inserted {i}/{inserts} elements"
            );
            i += 1;
        };
        i = 0;
        while i < inserts {
            assert!(!list.is_empty(), "List was empty before removing {i}/{inserts} elements");
            list.pop().unwrap();
            i += 1;
        };
        assert!(list.is_empty(), "List wasn't empty after having removed {inserts} elements");
        inserts += 1;
    };
}

#[test]
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

// #[test]
// fn from_array() {
//     let mut array: Array<ByteArray> = array!["1", "2", "3", "4"];
//     let mut list: SimpleLinkedList<ByteArray> = array.into();
//     let expected: Option<ByteArray> = Option::Some("4");
//     assert_eq!(list.pop(), expected);
//     let expected: Option<ByteArray> = Option::Some("3");
//     assert_eq!(list.pop(), expected);
//     let expected: Option<ByteArray> = Option::Some("2");
//     assert_eq!(list.pop(), expected);
//     let expected: Option<ByteArray> = Option::Some("1");
//     assert_eq!(list.pop(), expected);
// }

#[test]
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
fn into_vector() {
    let mut v: Array<u32> = array![];
    let mut s = SimpleLinkedListTrait::<u32>::new();
    let mut i = 1;
    while i < 4 {
        v.append(i);
        s.push(i);
        i += 1;
    };
    let s_as_vec: Array<u32> = s.into();
    assert_eq!(v, s_as_vec);
}
