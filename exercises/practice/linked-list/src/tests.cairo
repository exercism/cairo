use linked_list::{DoublyLinkedListTrait as DoublyLinkedList};

#[test]
fn pop_gets_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(7);
    assert_eq!(list.pop(), Option::Some(7));
}

#[test]
#[ignore]
fn push_pop_respectively_add_remove_at_the_end_of_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(11);
    list.push(13);
    assert_eq!(list.pop(), Option::Some(13));
    assert_eq!(list.pop(), Option::Some(11));
}

#[test]
#[ignore]
fn shift_gets_an_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(17);
    assert_eq!(list.shift(), Option::Some(17));
}

#[test]
#[ignore]
fn shift_gets_first_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(23);
    list.push(5);
    assert_eq!(list.shift(), Option::Some(23));
    assert_eq!(list.shift(), Option::Some(5));
}

#[test]
#[ignore]
fn unshift_adds_element_at_start_of_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.unshift(23);
    list.unshift(5);
    assert_eq!(list.shift(), Option::Some(5));
    assert_eq!(list.shift(), Option::Some(23));
}

#[test]
#[ignore]
fn pop_push_shift_and_unshift_can_be_used_in_any_order() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(1);
    list.push(2);
    assert_eq!(list.pop(), Option::Some(2));
    list.push(3);
    assert_eq!(list.shift(), Option::Some(1));
    list.unshift(4);
    list.push(5);
    assert_eq!(list.shift(), Option::Some(4));
    assert_eq!(list.pop(), Option::Some(5));
    assert_eq!(list.shift(), Option::Some(3));
}

#[test]
#[ignore]
fn count_an_empty_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    assert_eq!(list.len(), 0);
}

#[test]
#[ignore]
fn count_a_list_with_items() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(37);
    list.push(1);
    assert_eq!(list.len(), 2);
}

#[test]
#[ignore]
fn count_is_correct_after_mutation() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(31);
    assert_eq!(list.len(), 1);
    list.unshift(43);
    assert_eq!(list.len(), 2);
    let _ = list.shift();
    assert_eq!(list.len(), 1);
    let _ = list.pop();
    assert_eq!(list.len(), 0);
}

#[test]
#[ignore]
fn popping_to_empty_doesnt_break_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(41);
    list.push(59);
    let _ = list.pop();
    let _ = list.pop();
    list.push(47);
    assert_eq!(list.len(), 1);
    assert_eq!(list.pop(), Option::Some(47));
}

#[test]
#[ignore]
fn shifting_to_empty_doesnt_break_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(41);
    list.push(59);
    let _ = list.shift();
    let _ = list.shift();
    list.push(47);
    assert_eq!(list.len(), 1);
    assert_eq!(list.shift(), Option::Some(47));
}

#[test]
#[ignore]
fn deletes_the_only_element() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(61);
    list.delete(61);
    assert_eq!(list.len(), 0);
}

#[test]
#[ignore]
fn deletes_the_element_with_the_specified_value_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(71);
    list.push(83);
    list.push(79);
    list.delete(83);
    assert_eq!(list.len(), 2);
    assert_eq!(list.pop(), Option::Some(79));
    assert_eq!(list.shift(), Option::Some(71));
}

#[test]
#[ignore]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_tail() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(71);
    list.push(83);
    list.push(79);
    list.delete(83);
    assert_eq!(list.len(), 2);
    assert_eq!(list.pop(), Option::Some(79));
    assert_eq!(list.pop(), Option::Some(71));
}

#[test]
#[ignore]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_head() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(71);
    list.push(83);
    list.push(79);
    list.delete(83);
    assert_eq!(list.len(), 2);
    assert_eq!(list.shift(), Option::Some(71));
    assert_eq!(list.shift(), Option::Some(79));
}

#[test]
#[ignore]
fn deletes_the_first_of_two_elements() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(97);
    list.push(101);
    list.delete(97);
    assert_eq!(list.len(), 1);
    assert_eq!(list.pop(), Option::Some(101));
}

#[test]
#[ignore]
fn deletes_the_second_of_two_elements() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(97);
    list.push(101);
    list.delete(101);
    assert_eq!(list.len(), 1);
    assert_eq!(list.pop(), Option::Some(97));
}

#[test]
#[ignore]
fn delete_does_not_modify_the_list_if_the_element_is_not_found() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(89);
    list.delete(103);
    assert_eq!(list.len(), 1);
}

// Additional tests for this track

fn using_pop_returns_option_none_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    let none: Option<u32> = Option::None;
    assert_eq!(list.pop(), none);
}

fn can_return_with_pop_and_then_return_option_none_if_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(1);
    list.unshift(5);
    assert_eq!(list.pop(), Option::Some(1));
    assert_eq!(list.pop(), Option::Some(5));
    let none: Option<u32> = Option::None;
    assert_eq!(list.pop(), none);
}

#[test]
#[ignore]
fn deletes_only_the_first_occurrence() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(73);
    list.push(9);
    list.push(9);
    list.push(107);
    list.delete(9);
    assert_eq!(list.len(), 3);
    assert_eq!(list.pop(), Option::Some(107));
    assert_eq!(list.pop(), Option::Some(9));
    assert_eq!(list.pop(), Option::Some(73));
}

fn using_delete_does_nothing_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.delete(103);
    assert_eq!(list.len(), 0);
}


fn test_using_shift_raises_an_error_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    let none: Option<u32> = Option::None;
    assert_eq!(list.shift(), none);
}

fn can_return_with_shift_and_return_option_none_if_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(1);
    list.unshift(5);
    assert_eq!(list.pop(), Option::Some(1));
    assert_eq!(list.shift(), Option::Some(5));
    let none: Option<u32> = Option::None;
    assert_eq!(list.shift(), none);
}

