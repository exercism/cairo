use difference_of_squares::{squareOfSum, sumOfSquares, differenceOfSquares};

#[test]
fn square_of_sum_1() {
    let output = squareOfSum(1);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn square_of_sum_5() {
    let output = squareOfSum(5);
    let expected = 225;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn square_of_sum_100() {
    let output = squareOfSum(100);
    let expected = 25502500;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_1() {
    let output = sumOfSquares(1);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_5() {
    let output = sumOfSquares(5);
    let expected = 55;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn sum_of_squares_100() {
    let output = sumOfSquares(100);
    let expected = 338350;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_1() {
    let output = differenceOfSquares(1);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_5() {
    let output = differenceOfSquares(5);
    let expected = 170;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn difference_of_squares_100() {
    let output = differenceOfSquares(100);
    let expected = 25164150;
    assert_eq!(output, expected);
}
