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
    panic!("implement `colors`")
}

pub fn colors() -> Array<Color> {
    panic!("implement `colors`")
}
