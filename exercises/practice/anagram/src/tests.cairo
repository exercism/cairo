use anagram::{anagrams_for, SetTrait as Set};

#[test]
fn no_matches() {
    let word: ByteArray = "diaper";
    let inputs = Set::new(array!["hello", "world", "zombies", "pants"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_two_anagrams() {
    let word: ByteArray = "solemn";
    let inputs = Set::new(array!["lemons", "cherry", "melons"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["lemons", "melons"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn does_not_detect_anagram_subsets() {
    let word: ByteArray = "good";
    let inputs = Set::new(array!["dog", "goody"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_anagram() {
    let word: ByteArray = "listen";
    let inputs = Set::new(array!["enlists", "google", "inlets", "banana"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["inlets"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_three_anagrams() {
    let word: ByteArray = "allergy";
    let inputs = Set::new(
        array!["gallery", "ballerina", "regally", "clergy", "largely", "leading",]
    );
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["gallery", "regally", "largely"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_multiple_anagrams_with_different_case() {
    let word: ByteArray = "nose";
    let inputs = Set::new(array!["Eons", "ONES"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["Eons", "ONES"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn does_not_detect_non_anagrams_with_identical_checksum() {
    let word: ByteArray = "mass";
    let inputs = Set::new(array!["last"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_anagrams_case_insensitively() {
    let word: ByteArray = "Orchestra";
    let inputs = Set::new(array!["cashregister", "Carthorse", "radishes"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["Carthorse"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_anagrams_using_case_insensitive_subject() {
    let word: ByteArray = "Orchestra";
    let inputs = Set::new(array!["cashregister", "carthorse", "radishes"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["carthorse"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn detects_anagrams_using_case_insensitive_possible_matches() {
    let word: ByteArray = "orchestra";
    let inputs = Set::new(array!["cashregister", "Carthorse", "radishes"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["Carthorse"]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn does_not_detect_an_anagram_if_the_original_word_is_repeated() {
    let word: ByteArray = "go";
    let inputs = Set::new(array!["goGoGO"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn anagrams_must_use_all_letters_exactly_once() {
    let word: ByteArray = "tapper";
    let inputs = Set::new(array!["patter"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn words_are_not_anagrams_of_themselves() {
    let word: ByteArray = "BANANA";
    let inputs = Set::new(array!["BANANA"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn words_are_not_anagrams_of_themselves_even_if_letter_case_is_partially_different() {
    let word: ByteArray = "BANANA";
    let inputs = Set::new(array!["Banana"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn words_are_not_anagrams_of_themselves_even_if_letter_case_is_completely_different() {
    let word: ByteArray = "BANANA";
    let inputs = Set::new(array!["banana"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array![]);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn words_other_than_themselves_can_be_anagrams() {
    let word: ByteArray = "LISTEN";
    let inputs = Set::new(array!["LISTEN", "Silent"]);
    let output = anagrams_for(@word, @inputs);
    let expected = Set::new(array!["Silent"]);
    assert_eq!(output, expected);
}
