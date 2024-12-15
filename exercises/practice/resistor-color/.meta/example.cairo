#[derive(Drop, Debug, PartialEq)]
pub enum Color {
    Black,
    Brown,
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Violet,
    Grey,
    White,
}

pub fn color_code(color: Color) -> u8 {
    match color {
        Color::Black => 0,
        Color::Brown => 1,
        Color::Red => 2,
        Color::Orange => 3,
        Color::Yellow => 4,
        Color::Green => 5,
        Color::Blue => 6,
        Color::Violet => 7,
        Color::Grey => 8,
        Color::White => 9,
    }
}

pub fn colors() -> Array<Color> {
    array![
        Color::Black,
        Color::Brown,
        Color::Red,
        Color::Orange,
        Color::Yellow,
        Color::Green,
        Color::Blue,
        Color::Violet,
        Color::Grey,
        Color::White
    ]
}
