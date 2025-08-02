use secret_handshake::commands;

#[test]
#[ignore]
fn wink_for_one() {
    assert_eq!(commands(1), array!["wink"]);
}

#[test]
#[ignore]
fn double_blink_for_ten() {
    assert_eq!(commands(2), array!["double blink"]);
}

#[test]
#[ignore]
fn close_your_eyes_for_one_hundred() {
    assert_eq!(commands(4), array!["close your eyes"]);
}

#[test]
#[ignore]
fn jump_for_one_thousand() {
    assert_eq!(commands(8), array!["jump"]);
}

#[test]
#[ignore]
fn combine_two_actions() {
    assert_eq!(commands(3), array!["wink", "double blink"]);
}

#[test]
#[ignore]
fn reverse_two_actions() {
    assert_eq!(commands(19), array!["double blink", "wink"]);
}

#[test]
#[ignore]
fn reversing_one_action_gives_the_same_action() {
    assert_eq!(commands(24), array!["jump"]);
}

#[test]
#[ignore]
fn reversing_no_actions_still_gives_no_actions() {
    assert_eq!(commands(16), array![]);
}

#[test]
#[ignore]
fn all_possible_actions() {
    assert_eq!(commands(15), array!["wink", "double blink", "close your eyes", "jump"]);
}

#[test]
#[ignore]
fn reverse_all_possible_actions() {
    assert_eq!(commands(31), array!["jump", "close your eyes", "double blink", "wink"]);
}

#[test]
#[ignore]
fn do_nothing_for_zero() {
    assert_eq!(commands(0), array![]);
}
