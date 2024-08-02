use darts::score;

#[test]
fn missed_target() {
    let output = score(-9, 9);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn on_the_outer_circle() {
    let output = score(0, 10);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn on_the_middle_circle() {
    let output = score(-5, 0);
    let expected = 5;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn on_the_inner_circle() {
    let output = score(0, -1);
    let expected = 10;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn exactly_on_center() {
    let output = score(0, 0);
    let expected = 10;
    assert_eq!(output, expected);
}
