#[derive(Copy, Debug, Drop)]
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

pub fn value(colors: Array<Color>) -> u8 {
    color_value(*colors[0]) * 10 + color_value(*colors[1])
}

fn color_value(color: Color) -> u8 {
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
