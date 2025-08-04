use difference_of_squares::{
    difference_of_squares as diff_of_squares, square_of_sum, sum_of_squares,
};

#[test]
fn square_of_sum_1() {
    let output = square_of_sum(1);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn square_of_sum_5() {
    let output = square_of_sum(5);
    let expected = 225;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn square_of_sum_100() {
    let output = square_of_sum(100);
    let expected = 25502500;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_1() {
    let output = sum_of_squares(1);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_5() {
    let output = sum_of_squares(5);
    let expected = 55;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_100() {
    let output = sum_of_squares(100);
    let expected = 338350;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_1() {
    let output = diff_of_squares(1);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_5() {
    let output = diff_of_squares(5);
    let expected = 170;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_100() {
    let output = diff_of_squares(100);
    let expected = 25164150;
    assert_eq!(output, expected);
}
