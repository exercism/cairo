use core::dict::Felt252Dict;

pub fn score(word: ByteArray) -> u16 {
    let mut values = dictionary();
    let mut score = 0;
    let mut i = 0;
    while let Option::Some(char) = word.at(i) {
        score += values.get(lowercase(char).into());
        i += 1;
    }
    score
}

fn dictionary() -> Felt252Dict<u16> {
    let mut values: Felt252Dict<u16> = Default::default();
    values.insert('a', 1);
    values.insert('b', 3);
    values.insert('c', 3);
    values.insert('d', 2);
    values.insert('e', 1);
    values.insert('f', 4);
    values.insert('g', 2);
    values.insert('h', 4);
    values.insert('i', 1);
    values.insert('j', 8);
    values.insert('k', 5);
    values.insert('l', 1);
    values.insert('m', 3);
    values.insert('n', 1);
    values.insert('o', 1);
    values.insert('p', 3);
    values.insert('q', 10);
    values.insert('r', 1);
    values.insert('s', 1);
    values.insert('t', 1);
    values.insert('u', 1);
    values.insert('v', 4);
    values.insert('w', 4);
    values.insert('x', 8);
    values.insert('y', 4);
    values.insert('z', 10);
    values
}

fn lowercase(char: u8) -> u8 {
    if 'A' <= char && char <= 'Z' {
        char + 32
    } else {
        char
    }
}
