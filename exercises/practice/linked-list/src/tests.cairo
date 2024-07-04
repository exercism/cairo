use linked_list::{DoublyLinkedListTrait as DoublyLinkedList};

#[test]
fn pop_gets_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(7);
    assert_eq!(list.pop(), Option::Some(7));
}

#[test]
fn push_pop_respectively_add_remove_at_the_end_of_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(11);
    list.push(13);
    assert_eq!(list.pop(), Option::Some(13));
    assert_eq!(list.pop(), Option::Some(11));
}

#[test]
fn shift_gets_an_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(17);
    assert_eq!(list.shift(), Option::Some(17));
}

#[test]
fn shift_gets_first_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(23);
    list.push(5);
    assert_eq!(list.shift(), Option::Some(23));
    assert_eq!(list.shift(), Option::Some(5));
}

#[test]
fn unshift_adds_element_at_start_of_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.unshift(23)
    lst.unshift(5)
    self.assertEqual(lst.shift(), 5)
    self.assertEqual(lst.shift(), 23)
}

#[test]
fn pop_push_shift_and_unshift_can_be_used_in_any_order() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(1)
    lst.push(2)
    self.assertEqual(lst.pop(), 2)
    lst.push(3)
    self.assertEqual(lst.shift(), 1)
    lst.unshift(4)
    lst.push(5)
    self.assertEqual(lst.shift(), 4)
    self.assertEqual(lst.pop(), 5)
    self.assertEqual(lst.shift(), 3)
}

#[test]
fn count_an_empty_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    self.assertEqual(len(lst), 0)
}

#[test]
fn count_a_list_with_items() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(37)
    lst.push(1)
    self.assertEqual(len(lst), 2)
}

#[test]
fn count_is_correct_after_mutation() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(31)
    self.assertEqual(len(lst), 1)
    lst.unshift(43)
    self.assertEqual(len(lst), 2)
    lst.shift()
    self.assertEqual(len(lst), 1)
    lst.pop()
    self.assertEqual(len(lst), 0)
}

#[test]
fn popping_to_empty_doesnt_break_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(41)
    lst.push(59)
    lst.pop()
    lst.pop()
    lst.push(47)
    self.assertEqual(len(lst), 1)
    self.assertEqual(lst.pop(), 47)
}

#[test]
fn shifting_to_empty_doesnt_break_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(41)
    lst.push(59)
    lst.shift()
    lst.shift()
    lst.push(47)
    self.assertEqual(len(lst), 1)
    self.assertEqual(lst.shift(), 47)
}

#[test]
fn deletes_the_only_element() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(61)
    lst.delete(61)
    self.assertEqual(len(lst), 0)
}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(71)
    lst.push(83)
    lst.push(79)
    lst.delete(83)
    self.assertEqual(len(lst), 2)
    self.assertEqual(lst.pop(), 79)
    self.assertEqual(lst.shift(), 71)
}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_tail() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(71)
    lst.push(83)
    lst.push(79)
    lst.delete(83)
    self.assertEqual(len(lst), 2)
    self.assertEqual(lst.pop(), 79)
    self.assertEqual(lst.pop(), 71)
}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_head() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(71)
    lst.push(83)
    lst.push(79)
    lst.delete(83)
    self.assertEqual(len(lst), 2)
    self.assertEqual(lst.shift(), 71)
    self.assertEqual(lst.shift(), 79)
}

#[test]
fn deletes_the_first_of_two_elements() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(97)
    lst.push(101)
    lst.delete(97)
    self.assertEqual(len(lst), 1)
    self.assertEqual(lst.pop(), 101)
}

#[test]
fn deletes_the_second_of_two_elements() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(97)
    lst.push(101)
    lst.delete(101)
    self.assertEqual(len(lst), 1)
    self.assertEqual(lst.pop(), 97)
}

#[test]
fn delete_does_not_modify_the_list_if_the_element_is_not_found() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(89);
    list.delete(103);
    self.assertEqual(list.len(), 1);
}

// Additional tests for this track

fn using_pop_returns_option_none_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    self.assertEqual(lst.pop(), Option::None)
}

fn can_return_with_pop_and_then_return_option_none_if_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(1)
    lst.unshift(5)
    self.assertEqual(lst.pop(), 1)
    self.assertEqual(lst.pop(), 5)
    self.assertEqual(lst.pop(), Option::None)
}

#[test]
fn deletes_only_the_first_occurrence() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(73)
    lst.push(9)
    lst.push(9)
    lst.push(107)
    lst.delete(9)
    self.assertEqual(len(lst), 3)
    self.assertEqual(lst.pop(), 107)
    self.assertEqual(lst.pop(), 9)
    self.assertEqual(lst.pop(), 73)
}

fn using_delete_does_nothing_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.delete(103);
    self.assertEqual(list.len(), 0);
}


fn test_using_shift_raises_an_error_if_the_list_is_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    self.assertEqual(lst.shift(), Option::None)
}

fn can_return_with_shift_and_return_option_none_if_empty() {
    let mut list = DoublyLinkedList::<u32>::new();
    lst.push(1)
    lst.unshift(5)
    self.assertEqual(lst.pop(), 1)
    self.assertEqual(lst.shift(), 5)
    self.assertEqual(lst.shift(), Option::None)
}

