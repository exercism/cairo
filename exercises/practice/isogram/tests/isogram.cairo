use isogram::is_isogram;

#[test]
#[ignore]
fn empty_string() {
    let phrase = "";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn isogram_with_only_lower_case_characters() {
    let phrase = "isogram";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn word_with_one_duplicated_character() {
    let phrase = "eleven";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn word_with_one_duplicated_character_from_the_end_of_the_alphabet() {
    let phrase = "zzyzx";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn longest_reported_english_isogram() {
    let phrase = "subdermatoglyphic";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn word_with_duplicated_character_in_mixed_case() {
    let phrase = "Alphabet";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn word_with_duplicated_character_in_mixed_case_lowercase_first() {
    let phrase = "alphAbet";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn hypothetical_isogrammic_word_with_hyphen() {
    let phrase = "thumbscrew-japingly";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn hypothetical_word_with_duplicated_character_following_hyphen() {
    let phrase = "thumbscrew-jappingly";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn isogram_with_duplicated_hyphen() {
    let phrase = "six-year-old";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn made_up_name_that_is_an_isogram() {
    let phrase = "Emily Jung Schwartzkopf";
    assert!(is_isogram(phrase));
}

#[test]
#[ignore]
fn duplicated_character_in_the_middle() {
    let phrase = "accentor";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn same_first_and_last_characters() {
    let phrase = "angola";
    assert!(!is_isogram(phrase));
}

#[test]
#[ignore]
fn word_with_duplicated_character_and_with_two_hyphens() {
    let phrase = "up-to-date";
    assert!(!is_isogram(phrase));
}
