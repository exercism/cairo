use rotational_cipher::rotate;

#[test]
#[ignore]
fn rotate_a_by_0_same_output_as_input() {
    let text = "a";
    let shift_key = 0;
    assert_eq!(rotate(text, shift_key), "a");
}

#[test]
#[ignore]
fn rotate_a_by_1() {
    let text = "a";
    let shift_key = 1;
    assert_eq!(rotate(text, shift_key), "b");
}

#[test]
#[ignore]
fn rotate_a_by_26_same_output_as_input() {
    let text = "a";
    let shift_key = 26;
    assert_eq!(rotate(text, shift_key), "a");
}

#[test]
#[ignore]
fn rotate_m_by_13() {
    let text = "m";
    let shift_key = 13;
    assert_eq!(rotate(text, shift_key), "z");
}

#[test]
#[ignore]
fn rotate_n_by_13_with_wrap_around_alphabet() {
    let text = "n";
    let shift_key = 13;
    assert_eq!(rotate(text, shift_key), "a");
}

#[test]
#[ignore]
fn rotate_capital_letters() {
    let text = "OMG";
    let shift_key = 5;
    assert_eq!(rotate(text, shift_key), "TRL");
}

#[test]
#[ignore]
fn rotate_spaces() {
    let text = "O M G";
    let shift_key = 5;
    assert_eq!(rotate(text, shift_key), "T R L");
}

#[test]
#[ignore]
fn rotate_numbers() {
    let text = "Testing 1 2 3 testing";
    let shift_key = 4;
    assert_eq!(rotate(text, shift_key), "Xiwxmrk 1 2 3 xiwxmrk");
}

#[test]
#[ignore]
fn rotate_punctuation() {
    let text = "Let's eat, Grandma!";
    let shift_key = 21;
    assert_eq!(rotate(text, shift_key), "Gzo'n zvo, Bmviyhv!");
}

#[test]
#[ignore]
fn rotate_all_letters() {
    let text = "The quick brown fox jumps over the lazy dog.";
    let shift_key = 13;
    assert_eq!(rotate(text, shift_key), "Gur dhvpx oebja sbk whzcf bire gur ynml qbt.");
}
