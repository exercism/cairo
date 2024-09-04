pub fn can_fast_attack(knight_awake: bool) -> bool {
    return !knight_awake;
}

pub fn can_spy(knight_awake: bool, archer_awake: bool, prisoner_awake: bool) -> bool {
    return knight_awake || archer_awake || prisoner_awake;
}

pub fn can_signal_prisoner(archer_awake: bool, prisoner_awake: bool) -> bool {
    return !archer_awake && prisoner_awake;
}

pub fn can_free_prisoner(
    knight_awake: bool, archer_awake: bool, prisoner_awake: bool, dog_present: bool
) -> bool {
    return (prisoner_awake && !knight_awake && !archer_awake) || (dog_present && !archer_awake);
}