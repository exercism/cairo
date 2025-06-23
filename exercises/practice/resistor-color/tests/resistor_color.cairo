use resistor_color::{color_code, colors, Color};


#[test]
fn black() {
    let output = color_code(Color::Black);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn white() {
    let output = color_code(Color::White);
    let expected = 9;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn orange() {
    let output = color_code(Color::Orange);
    let expected = 3;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn test_colors() {
    let output = colors();
    let expected = array![
        Color::Black,
        Color::Brown,
        Color::Red,
        Color::Orange,
        Color::Yellow,
        Color::Green,
        Color::Blue,
        Color::Violet,
        Color::Grey,
        Color::White,
    ];
    assert_eq!(output, expected);
}
