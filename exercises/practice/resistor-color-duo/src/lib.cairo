#[derive(Debug, Drop)]
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
    panic!("implement `value`")
}
