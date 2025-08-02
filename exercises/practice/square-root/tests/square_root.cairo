use square_root::sqrt;

#[test]
fn root_of_1() {
    let output = sqrt(1);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn root_of_4() {
    let output = sqrt(4);
    let expected = 2;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn root_of_25() {
    let output = sqrt(25);
    let expected = 5;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn root_of_81() {
    let output = sqrt(81);
    let expected = 9;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn root_of_196() {
    let output = sqrt(196);
    let expected = 14;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn root_of_65025() {
    let output = sqrt(65025);
    let expected = 255;
    assert_eq!(output, expected);
}
