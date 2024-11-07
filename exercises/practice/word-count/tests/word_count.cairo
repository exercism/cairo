use super::word_count;
use super::bytearray_to_felt252; // handle bytearray for invocation from Felt252Dict

#[test]
fn count_one_word() {
    let input = "word";
    let mut output = word_count(input);
    let expected_count = 1;
    assert_eq!(output.get('word'), expected_count);
}

#[test]
fn count_one_of_each_word() {
    let input = "one of each";
    let mut output = word_count(input);
    let expected_count_one = 1;

    assert_eq!(output.get('one'), expected_count_one);
    assert_eq!(output.get('of'), expected_count_one);
    assert_eq!(output.get('each'), expected_count_one);
}

#[test]
fn multiple_occurrences_of_a_word() {
    let input = "one fish two fish red fish blue fish";
    let mut output = word_count(input);
    let expected_count_one = 1;
    let expected_count_four = 4;

    assert_eq!(output.get('one'), expected_count_one);
    assert_eq!(output.get('fish'), expected_count_four);
    assert_eq!(output.get('red'), expected_count_one);
    assert_eq!(output.get('blue'), expected_count_one);
    assert_eq!(output.get('two'), expected_count_one);
}

#[test]
fn handles_cramped_lists() {
    let input = "one,two,three";
    let mut output = word_count(input);

    let expected_count_one = 1;

    assert_eq!(output.get('one'), expected_count_one);
    assert_eq!(output.get('two'), expected_count_one);
    assert_eq!(output.get('three'), expected_count_one);
}

#[test]
fn handles_expanded_lists() {
    let input = "one,\ntwo,\nthree";
    let mut output = word_count(input);

    let expected_count_one = 1;

    assert_eq!(output.get('one'), expected_count_one);
    assert_eq!(output.get('two'), expected_count_one);
    assert_eq!(output.get('three'), expected_count_one);
}

#[test]
fn ignore_punctuation() {
    let input = "car: carpet as java: javascript!!&@$%^&";
    let mut output = word_count(input);

    let expected_count_one = 1;

    assert_eq!(output.get('car'), expected_count_one);
    assert_eq!(output.get('carpet'), expected_count_one);
    assert_eq!(output.get('as'), expected_count_one);
    assert_eq!(output.get('as'), expected_count_one);
    assert_eq!(output.get('java'), expected_count_one);
    assert_eq!(output.get('java'), expected_count_one);
    assert_eq!(output.get('javascript'), expected_count_one);
}

#[test]
fn include_numbers() {
    let input = "testing, 1, 2 testing";
    let mut output = word_count(input);

    let expected_count_1 = 1;
    let expected_count_2 = 2;

    assert_eq!(output.get('testing'), expected_count_2);
    assert_eq!(output.get('1'), expected_count_1);
    assert_eq!(output.get('2'), expected_count_1);
}

#[test]
fn normalize_case() {
    let input = "go Go GO Stop stop";
    let mut output = word_count(input);

    let expected_count_go = 3;
    let expected_count_stop = 2;

    assert_eq!(output.get('go'), expected_count_go);
    assert_eq!(output.get('stop'), expected_count_stop);
}

#[test]
fn with_apostrophes() {
    let input = "'First: don't laugh. Then: don't cry. You're getting it.'";
    let mut output = word_count(input);

    let expected_count_one = 1;
    let expected_count_two = 2;

    assert_eq!(output.get('first'), expected_count_one);
    assert_eq!(output.get(bytearray_to_felt252(@"don't")), expected_count_two);
    assert_eq!(output.get('laugh'), expected_count_one);
    assert_eq!(output.get('then'), expected_count_one);
    assert_eq!(output.get('cry'), expected_count_one);
    assert_eq!(output.get(bytearray_to_felt252(@"you're")), expected_count_one);
    assert_eq!(output.get('getting'), expected_count_one);
    assert_eq!(output.get('it'), expected_count_one);
}

#[test]
fn with_quotations() {
    let input = "Joe can't tell between 'large' and large.";
    let mut output = word_count(input);

    let expected_count_one = 1;
    let expected_count_two = 2;

    assert_eq!(output.get('joe'), expected_count_one);
    assert_eq!(output.get(bytearray_to_felt252(@"can't")), expected_count_one);
    assert_eq!(output.get('tell'), expected_count_one);
    assert_eq!(output.get('between'), expected_count_one);
    assert_eq!(output.get('large'), expected_count_two);
    assert_eq!(output.get('and'), expected_count_one);
}

#[test]
fn substrings_from_the_beginning() {
    let input = "Joe can't tell between app, apple and a.";
    let mut output = word_count(input);

    let expected_count_one = 1;

    assert_eq!(output.get('joe'), expected_count_one);
    assert_eq!(output.get(bytearray_to_felt252(@"can't")), expected_count_one);
    assert_eq!(output.get('tell'), expected_count_one);
    assert_eq!(output.get('between'), expected_count_one);
    assert_eq!(output.get('app'), expected_count_one);
    assert_eq!(output.get('apple'), expected_count_one);
    assert_eq!(output.get('and'), expected_count_one);
    assert_eq!(output.get('a'), expected_count_one);
}

#[test]
fn multiple_spaces_not_detected_as_a_word() {
    let input = " multiple   whitespaces";
    let mut output = word_count(input);

    let expected_count_one = 1;

    assert_eq!(output.get('multiple'), expected_count_one);
    assert_eq!(output.get('whitespaces'), expected_count_one);
}

#[test]
fn alternating_word_separators_not_detected_as_a_word() {
    let input = ",\n,one,\n ,two \n 'three'";
    let mut output = word_count(input);
    let expected_count_one = 1;

    assert_eq!(output.get('one'), expected_count_one);
    assert_eq!(output.get('two'), expected_count_one);
    assert_eq!(output.get('three'), expected_count_one);
}

#[test]
fn quotation_for_word_with_apostrophe() {
    let input = "can, can't, 'can't'";
    let mut output = word_count(input);

    let expected_count_one = 1;
    let expected_count_two = 2;

    assert_eq!(output.get('can'), expected_count_one);
    assert_eq!(output.get(bytearray_to_felt252(@"can't")), expected_count_two);
}
