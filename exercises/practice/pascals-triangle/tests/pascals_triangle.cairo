use pascals_triangle::rows;

#[test]
fn zero_rows() {
    let output = rows(0);
    let expected: Array<Array<u32>> = array![];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn single_row() {
    let output = rows(1);
    let expected: Array<Array<u32>> = array![array![1]];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn two_rows() {
    let output = rows(2);
    let expected: Array<Array<u32>> = array![array![1], array![1, 1]];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn three_rows() {
    let output = rows(3);
    let expected: Array<Array<u32>> = array![array![1], array![1, 1], array![1, 2, 1]];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_rows() {
    let output = rows(4);
    let expected: Array<Array<u32>> = array![
        array![1], array![1, 1], array![1, 2, 1], array![1, 3, 3, 1],
    ];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn five_rows() {
    let output = rows(5);
    let expected: Array<Array<u32>> = array![
        array![1], array![1, 1], array![1, 2, 1], array![1, 3, 3, 1], array![1, 4, 6, 4, 1],
    ];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn six_rows() {
    let output = rows(6);
    let expected: Array<Array<u32>> = array![
        array![1],
        array![1, 1],
        array![1, 2, 1],
        array![1, 3, 3, 1],
        array![1, 4, 6, 4, 1],
        array![1, 5, 10, 10, 5, 1],
    ];
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn ten_rows() {
    let output = rows(10);
    let expected: Array<Array<u32>> = array![
        array![1],
        array![1, 1],
        array![1, 2, 1],
        array![1, 3, 3, 1],
        array![1, 4, 6, 4, 1],
        array![1, 5, 10, 10, 5, 1],
        array![1, 6, 15, 20, 15, 6, 1],
        array![1, 7, 21, 35, 35, 21, 7, 1],
        array![1, 8, 28, 56, 70, 56, 28, 8, 1],
        array![1, 9, 36, 84, 126, 126, 84, 36, 9, 1],
    ];
    assert_eq!(output, expected);
}
