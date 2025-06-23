#[derive(Drop)]
pub enum Category {
    Ones,
    Twos,
    Threes,
    Fours,
    Fives,
    Sixes,
    FullHouse,
    FourOfAKind,
    LittleStraight,
    BigStraight,
    Choice,
    Yacht,
}

pub fn score(dice: [u8; 5], category: Category) -> u8 {
    panic!("implement `score`")
}
