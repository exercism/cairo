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
    Yacht
}

#[derive(Copy, Default, Drop, PartialEq)]
struct Counter {
    ones: u8,
    twos: u8,
    threes: u8,
    fours: u8,
    fives: u8,
    sixes: u8,
}

pub fn score(dice: [u8; 5], category: Category) -> u8 {
    let span = dice.span();
    let counter = count_dice(span);
    match category {
        Category::Ones => 1 * counter.ones,
        Category::Twos => 2 * counter.twos,
        Category::Threes => 3 * counter.threes,
        Category::Fours => 4 * counter.fours,
        Category::Fives => 5 * counter.fives,
        Category::Sixes => 6 * counter.sixes,
        Category::FullHouse => {
            if has_count(counter, 3) && has_count(counter, 2) {
                sum(span)
            } else {
                0
            }
        },
        Category::FourOfAKind => {
            if counter.ones >= 4 {
                4 * 1
            } else if counter.twos >= 4 {
                4 * 2
            } else if counter.threes >= 4 {
                4 * 3
            } else if counter.fours >= 4 {
                4 * 4
            } else if counter.fives >= 4 {
                4 * 5
            } else if counter.sixes >= 4 {
                4 * 6
            } else {
                0
            }
        },
        Category::LittleStraight => {
            let expected = Counter { ones: 1, twos: 1, threes: 1, fours: 1, fives: 1, sixes: 0 };
            if counter == expected {
                30
            } else {
                0
            }
        },
        Category::BigStraight => {
            let expected = Counter { ones: 0, twos: 1, threes: 1, fours: 1, fives: 1, sixes: 1 };
            if counter == expected {
                30
            } else {
                0
            }
        },
        Category::Choice => sum(span),
        Category::Yacht => { if has_count(counter, 5) {
            50
        } else {
            0
        } },
    }
}

fn has_count(counter: Counter, number: u8) -> bool {
    counter.ones == number
        || counter.twos == number
        || counter.threes == number
        || counter.fours == number
        || counter.fives == number
        || counter.sixes == number
}

fn count_dice(dice: Span<u8>) -> Counter {
    let mut counter: Counter = Default::default();
    let mut i: u32 = 0;
    while i < 5 {
        match dice.get(i) {
            Option::Some(v) => {
                match *v.unbox() {
                    0 => {},
                    1 => counter.ones += 1,
                    2 => counter.twos += 1,
                    3 => counter.threes += 1,
                    4 => counter.fours += 1,
                    5 => counter.fives += 1,
                    6 => counter.sixes += 1,
                    _ => {}
                }
            },
            Option::None => {}
        }
        i += 1;
    };

    counter
}

fn sum(dice: Span<u8>) -> u8 {
    let mut sum = 0;
    let mut i: u32 = 0;
    while i < dice.len() {
        match dice.get(i) {
            Option::Some(v) => sum += *v.unbox(),
            Option::None => { panic!("went out of bounds somehow") }
        }
        i += 1;
    };

    sum
}
