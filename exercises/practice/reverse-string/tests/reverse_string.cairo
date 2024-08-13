use reverse_string::reverse;

#[test]
fn an_empty_string() {
    let value = "";
    let output = reverse(value);
    let expected = "";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn a_word() {
    let value = "robot";
    let output = reverse(value);
    let expected = "tobor";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn a_capitalized_word() {
    let value = "Ramen";
    let output = reverse(value);
    let expected = "nemaR";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn a_sentence_with_punctuation() {
    let value = "I'm hungry!";
    let output = reverse(value);
    let expected = "!yrgnuh m'I";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn a_palindrome() {
    let value = "racecar";
    let output = reverse(value);
    let expected = "racecar";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn an_even_sized_word() {
    let value = "drawer";
    let output = reverse(value);
    let expected = "reward";
    assert_eq!(output, expected);
}
