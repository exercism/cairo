use simple_linked_list::{SimpleLinkedList, SimpleLinkedListTrait};

// count

#[test]
fn empty_list_has_length_of_zero() {
    let list = SimpleLinkedListTrait::<u32>::new();
    assert_eq!(list.len(), 0);
}

#[test]
#[ignore]
fn singleton_list_has_length_of_one() {
    let list: SimpleLinkedList<u32> = array![1].into();
    assert_eq!(list.len(), 1);
}

#[test]
#[ignore]
fn non_empty_list_has_correct_length() {
    let list: SimpleLinkedList<u32> = array![1, 2, 3].into();
    assert_eq!(list.len(), 3);
}

// pop

#[test]
#[ignore]
fn pop_from_empty_list_is_an_error() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    let none: Option<u32> = Option::None;
    assert_eq!(list.pop(), none);
}

#[test]
#[ignore]
fn can_pop_from_singleton_list() {
    let mut list: SimpleLinkedList<u32> = array![1].into();
    assert_eq!(list.pop(), Option::Some(1));
}

#[test]
#[ignore]
fn can_pop_from_non_empty_list() {
    let mut list: SimpleLinkedList<u32> = array![1, 2].into();
    assert_eq!(list.pop(), Option::Some(2));
}

#[test]
#[ignore]
fn can_pop_multiple_items() {
    let mut list: SimpleLinkedList<u32> = array![1, 2].into();
    assert_eq!(list.pop(), Option::Some(2));
    assert_eq!(list.pop(), Option::Some(1));
}

#[test]
#[ignore]
fn pop_updates_the_count() {
    let mut list: SimpleLinkedList<u32> = array![1, 2].into();
    assert_eq!(list.len(), 2);
    assert_eq!(list.pop(), Option::Some(2));
    assert_eq!(list.len(), 1);
    assert_eq!(list.pop(), Option::Some(1));
    assert_eq!(list.len(), 0);
}

// push

#[test]
#[ignore]
fn can_push_to_an_empty_list() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    assert_eq!(list.peek(), Option::Some(@1));
}

#[test]
#[ignore]
fn can_push_to_a_non_empty_list() {
    let mut list: SimpleLinkedList<u32> = array![1, 2].into();
    list.push(3);
    assert_eq!(list.peek(), Option::Some(@3));
}

#[test]
#[ignore]
fn push_updates_count() {
    let mut list: SimpleLinkedList<u32> = array![1, 2].into();
    list.push(3);
    assert_eq!(list.len(), 3);
}

#[test]
#[ignore]
fn push_and_pop() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    assert_eq!(list.pop(), Option::Some(2));
    list.push(3);
    assert_eq!(list.len(), 2);
    assert_eq!(list.pop(), Option::Some(3));
    assert_eq!(list.pop(), Option::Some(1));
    assert_eq!(list.len(), 0);
}

// peek

#[test]
#[ignore]
fn peek_on_empty_list_is_an_error() {
    let list = SimpleLinkedListTrait::<u32>::new();
    let none: Option<@u32> = Option::None;
    assert_eq!(list.peek(), none);
}

#[test]
#[ignore]
fn can_peek_on_singleton_list() {
    let list: SimpleLinkedList<u32> = array![1].into();
    assert_eq!(list.peek(), Option::Some(@1));
}

#[test]
#[ignore]
fn can_peek_on_non_empty_list() {
    let list: SimpleLinkedList<u32> = array![1, 2].into();
    assert_eq!(list.peek(), Option::Some(@2));
}

#[test]
#[ignore]
fn peek_does_not_change_the_count() {
    let list: SimpleLinkedList<u32> = array![1, 2].into();
    assert_eq!(list.peek(), Option::Some(@2));
    assert_eq!(list.len(), 2);
}

#[test]
#[ignore]
fn can_peek_after_a_pop_and_push() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    assert_eq!(list.peek(), Option::Some(@2));
    assert_eq!(list.pop(), Option::Some(2));
    assert_eq!(list.peek(), Option::Some(@1));
    list.push(3);
    assert_eq!(list.peek(), Option::Some(@3));
}

// toList FIFO

#[test]
#[ignore]
fn empty_linked_list_to_list_is_empty() {
    let list = SimpleLinkedListTrait::<u32>::new();
    let arr: Array<u32> = list.into();
    assert_eq!(arr, array![]);
}

#[test]
#[ignore]
fn to_list_with_multiple_values() {
    let list: SimpleLinkedList<u32> = array![1, 2, 3].into();
    let arr: Array<u32> = list.into();
    assert_eq!(arr, array![1, 2, 3]);
}

#[test]
#[ignore]
fn to_list_after_a_pop() {
    let mut list = SimpleLinkedListTrait::<u32>::new();
    list.push(1);
    list.push(2);
    list.push(3);
    assert_eq!(list.pop(), Option::Some(3));
    list.push(4);
    let arr: Array<u32> = list.into();
    assert_eq!(arr, array![1, 2, 4]);
}

// reverse

#[test]
#[ignore]
fn reversed_empty_list_has_same_values() {
    let list = SimpleLinkedListTrait::<u32>::new();
    let rev_list = list.rev();
    let arr: Array<u32> = rev_list.into();
    assert_eq!(arr, array![]);
}

#[test]
#[ignore]
fn reversed_singleton_list_is_same_list() {
    let list: SimpleLinkedList<u32> = array![1].into();
    let rev_list = list.rev();
    let arr: Array<u32> = rev_list.into();
    assert_eq!(arr, array![1]);
}

#[test]
#[ignore]
fn reversed_non_empty_list_is_reversed() {
    let list: SimpleLinkedList<u32> = array![1, 2, 3].into();
    let mut rev_list = list.rev();
    assert_eq!(rev_list.len(), 3);
    assert_eq!(rev_list.pop(), Option::Some(1));
    assert_eq!(rev_list.pop(), Option::Some(2));
    assert_eq!(rev_list.pop(), Option::Some(3));
}

#[test]
#[ignore]
fn double_reverse() {
    let list: SimpleLinkedList<u32> = array![1, 2, 3].into();
    let mut list = list.rev().rev();
    assert_eq!(list.pop(), Option::Some(3));
    assert_eq!(list.pop(), Option::Some(2));
    assert_eq!(list.pop(), Option::Some(1));
}
