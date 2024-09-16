use bob::response;

#[test]
fn stating_something() {
    let input = "Tom-ay-to, tom-aaaah-to.";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn shouting() {
    let input = "WATCH OUT!";
    assert_eq!("Whoa, chill out!", response(@input));
}

#[test]
#[ignore]
fn shouting_gibberish() {
    let input = "FCECDFCAAB";
    assert_eq!("Whoa, chill out!", response(@input));
}

#[test]
#[ignore]
fn asking_a_question() {
    let input = "Does this cryogenic chamber make me look fat?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn asking_a_numeric_question() {
    let input = "You are, what, like 15?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn asking_gibberish() {
    let input = "fffbbcbeab?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn talking_forcefully() {
    let input = "Hi there!";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn using_acronyms_in_regular_speech() {
    let input = "It's OK if you don't want to go work for NASA.";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn forceful_question() {
    let input = "WHAT'S GOING ON?";
    assert_eq!("Calm down, I know what I'm doing!", response(@input));
}

#[test]
#[ignore]
fn shouting_numbers() {
    let input = "1, 2, 3 GO!";
    assert_eq!("Whoa, chill out!", response(@input));
}

#[test]
#[ignore]
fn no_letters() {
    let input = "1, 2, 3";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn question_with_no_letters() {
    let input = "4?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn shouting_with_special_characters() {
    let input = "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!";
    assert_eq!("Whoa, chill out!", response(@input));
}

#[test]
#[ignore]
fn shouting_with_no_exclamation_mark() {
    let input = "I HATE THE DENTIST";
    assert_eq!("Whoa, chill out!", response(@input));
}

#[test]
#[ignore]
fn statement_containing_question_mark() {
    let input = "Ending with ? means a question.";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn non_letters_with_question() {
    let input = ":) ?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn prattling_on() {
    let input = "Wait! Hang on. Are you going to be OK?";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn silence() {
    let input = "";
    assert_eq!("Fine. Be that way!", response(@input));
}

#[test]
#[ignore]
fn prolonged_silence() {
    let input = "          ";
    assert_eq!("Fine. Be that way!", response(@input));
}

#[test]
#[ignore]
fn alternate_silence() {
    let input = "\t\t\t\t\t\t\t\t\t\t";
    assert_eq!("Fine. Be that way!", response(@input));
}

#[test]
#[ignore]
fn multiple_line_question() {
    let input = "\nDoes this cryogenic chamber make me look fat?\nNo.";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn starting_with_whitespace() {
    let input = "         hmmmmmmm...";
    assert_eq!("Whatever.", response(@input));
}

#[test]
#[ignore]
fn ending_with_whitespace() {
    let input = "Okay if like my  spacebar  quite a bit?   ";
    assert_eq!("Sure.", response(@input));
}

#[test]
#[ignore]
fn other_whitespace() {
    let input = "\n\r \t";
    assert_eq!("Fine. Be that way!", response(@input));
}

#[test]
#[ignore]
fn non_question_ending_with_whitespace() {
    let input = "This is a statement ending with whitespace      ";
    assert_eq!("Whatever.", response(@input));
}
