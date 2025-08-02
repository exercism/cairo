use resistor_color_duo::{value, Color};

#[test]
#[ignore]
fn brown_and_black() {
    let colors = array![Color::Brown, Color::Black];
    let output = value(colors);
    let expected = 10;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn blue_and_grey() {
    let colors = array![Color::Blue, Color::Grey];
    let output = value(colors);
    let expected = 68;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn yellow_and_violet() {
    let colors = array![Color::Yellow, Color::Violet];
    let output = value(colors);
    let expected = 47;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn white_and_red() {
    let colors = array![Color::White, Color::Red];
    let output = value(colors);
    let expected = 92;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn orange_and_orange() {
    let colors = array![Color::Orange, Color::Orange];
    let output = value(colors);
    let expected = 33;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn ignore_additional_colors() {
    let colors = array![Color::Green, Color::Brown, Color::Orange];
    let output = value(colors);
    let expected = 51;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn black_and_brown_one_digit() {
    let colors = array![Color::Black, Color::Brown];
    let output = value(colors);
    let expected = 1;
    assert_eq!(output, expected);
}
