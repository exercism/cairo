use annalyns_infiltration::{can_fast_attack, can_spy, can_signal_prisoner, can_free_prisoner};

// The following tests are for the `can_fast_attack` function.

#[test]
fn can_not_fast_attack_if_knight_is_awake() {
    let knight_awake = true;
    assert!(!can_fast_attack(knight_awake));
}

#[test]
#[ignore]
fn can_fast_attack_if_knight_is_not_awake() {
    let knight_awake = false;
    assert!(can_fast_attack(knight_awake));
}

// The following tests are for the `can_spy` function.

#[test]
#[ignore]
fn can_not_spy_if_all_characters_are_sleeping() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = false;
    assert!(!can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_knight_is_awake() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = false;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_prisoner_is_asleep() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = false;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_archer_is_asleep() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = true;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_archer_is_awake() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = false;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_knight_is_asleep() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = true;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_only_prisoner_is_awake() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = true;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_spy_if_all_characters_are_awake() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = true;
    assert!(can_spy(knight_awake, archer_awake, prisoner_awake));
}

// The following tests are for the `can_signal_prisoner` function.

#[test]
#[ignore]
fn can_not_signal_prisoner_if_all_characters_are_asleep() {
    let archer_awake = false;
    let prisoner_awake = false;
    assert!(!can_signal_prisoner(archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_signal_prisoner_if_only_archer_is_asleep() {
    let archer_awake = false;
    let prisoner_awake = true;
    assert!(can_signal_prisoner(archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_not_signal_prisoner_if_only_archer_is_awake() {
    let archer_awake = true;
    let prisoner_awake = false;
    assert!(!can_signal_prisoner(archer_awake, prisoner_awake));
}

#[test]
#[ignore]
fn can_not_signal_prisoner_if_all_characters_are_awake() {
    let archer_awake = true;
    let prisoner_awake = true;
    assert!(!can_signal_prisoner(archer_awake, prisoner_awake));
}

// The following tests are for the `can_free_prisoner` function.

#[test]
#[ignore]
fn can_not_free_prisoner_if_all_characters_are_asleep_and_dog_is_not_present() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = false;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_free_prisoner_if_all_characters_are_asleep_and_dog_is_present() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = false;
    let dog_present = true;
    assert!(can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_free_prisoner_if_only_prisoner_is_awake_and_dog_is_not_present() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = true;
    let dog_present = false;
    assert!(can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_free_prisoner_if_only_prisoner_is_awake_and_dog_is_present() {
    let knight_awake = false;
    let archer_awake = false;
    let prisoner_awake = true;
    let dog_present = true;
    assert!(can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_archer_is_awake_and_dog_is_not_present() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = false;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_archer_is_awake_and_dog_is_present() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = false;
    let dog_present = true;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_knight_is_asleep_and_dog_is_not_present() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = true;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_knight_is_asleep_and_dog_is_present() {
    let knight_awake = false;
    let archer_awake = true;
    let prisoner_awake = true;
    let dog_present = true;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_knight_is_awake_and_dog_is_not_present() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = false;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_free_prisoner_if_only_knight_is_awake_and_dog_is_present() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = false;
    let dog_present = true;
    assert!(can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_archer_is_asleep_and_dog_is_not_present() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = true;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_free_prisoner_if_only_archer_is_asleep_and_dog_is_present() {
    let knight_awake = true;
    let archer_awake = false;
    let prisoner_awake = true;
    let dog_present = true;
    assert!(can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_prisoner_is_asleep_and_dog_is_not_present() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = false;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_only_prisoner_is_asleep_and_dog_is_present() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = false;
    let dog_present = true;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_all_characters_are_awake_and_dog_is_not_present() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = true;
    let dog_present = false;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}

#[test]
#[ignore]
fn can_not_free_prisoner_if_all_characters_are_awake_and_dog_is_present() {
    let knight_awake = true;
    let archer_awake = true;
    let prisoner_awake = true;
    let dog_present = true;
    assert!(!can_free_prisoner(knight_awake, archer_awake, prisoner_awake, dog_present));
}
