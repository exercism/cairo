use linked_list::{DoublyLinkedListTrait as DoublyLinkedList};

#[test]
fn pop_gets_element_from_the_list() {
    let mut list = DoublyLinkedList::<u32>::new();
    list.push(7);
    assert_eq!(list.pop(), Option::Some(7));
}

#[test]
fn push_pop_respectively_add_remove_at_the_end_of_the_list() {}

#[test]
fn shift_gets_an_element_from_the_list() {}

#[test]
fn shift_gets_first_element_from_the_list() {}

#[test]
fn unshift_adds_element_at_start_of_the_list() {}

#[test]
fn pop_push_shift_and_unshift_can_be_used_in_any_order() {}

#[test]
fn count_an_empty_list() {}

#[test]
fn count_a_list_with_items() {}

#[test]
fn count_is_correct_after_mutation() {}

#[test]
fn popping_to_empty_doesnt_break_the_list() {}

#[test]
fn shifting_to_empty_doesnt_break_the_list() {}

#[test]
fn deletes_the_only_element() {}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list() {}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_tail() {}

#[test]
fn deletes_the_element_with_the_specified_value_from_the_list_reassigns_head() {}

#[test]
fn deletes_the_first_of_two_elements() {}

#[test]
fn deletes_the_second_of_two_elements() {}

#[test]
fn delete_does_not_modify_the_list_if_the_element_is_not_found() {}

#[test]
fn deletes_only_the_first_occurrence() {}
