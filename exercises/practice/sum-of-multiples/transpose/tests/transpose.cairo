use transpose::transpose;

#[test]
fn empty_string() {
    let mut input: Array<ByteArray> = array![];
    let expected = array![];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn two_characters_in_a_row() {
    let mut input: Array<ByteArray> = array!["A1"];
    let expected = array!["A", "1"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn two_characters_in_a_column() {
    let mut input: Array<ByteArray> = array!["A", "1"];
    let expected = array!["A1"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn simple() {
    let mut input: Array<ByteArray> = array!["ABC", "123"];
    let expected = array!["A1", "B2", "C3"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn single_line() {
    let mut input: Array<ByteArray> = array!["Single line."];
    let expected = array!["S", "i", "n", "g", "l", "e", " ", "l", "i", "n", "e", "."];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn first_line_longer_than_second_line() {
    let mut input: Array<ByteArray> = array!["The fourth line.", "The fifth line."];
    let expected = array![
        "TT",
        "hh",
        "ee",
        "  ",
        "ff",
        "oi",
        "uf",
        "rt",
        "th",
        "h ",
        " l",
        "li",
        "in",
        "ne",
        "e.",
        ". "
    ];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn second_line_longer_than_first_line() {
    let mut input: Array<ByteArray> = array!["The first line.", "The second line."];
    let expected = array![
        "TT",
        "hh",
        "ee",
        "  ",
        "fs",
        "ie",
        "rc",
        "so",
        "tn",
        " d",
        "l ",
        "il",
        "ni",
        "en",
        ".e",
        " ."
    ];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn mixed_line_length() {
    let mut input: Array<ByteArray> = array![
        "The longest line.", "A long line.", "A longer line.", "A line."
    ];
    let expected = array![
        "TAAA",
        "h   ",
        "elll",
        " ooi",
        "lnnn",
        "ogge",
        "n e.",
        "glr ",
        "ei  ",
        "snl ",
        "tei ",
        " .n ",
        "l e ",
        "i . ",
        "n   ",
        "e   ",
        ".   "
    ];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn square() {
    let mut input: Array<ByteArray> = array!["HEART", "EMBER", "ABUSE", "RESIN", "TREND"];
    let expected = array!["HEART", "EMBER", "ABUSE", "RESIN", "TREND"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn rectangle() {
    let mut input: Array<ByteArray> = array!["FRACTURE", "OUTLINED", "BLOOMING", "SEPTETTE"];
    let expected = array!["FOBS", "RULE", "ATOP", "CLOT", "TIME", "UNIT", "RENT", "EDGE"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn triangle() {
    let mut input: Array<ByteArray> = array!["T", "EE", "AAA", "SSSS", "EEEEE", "RRRRRR"];
    let expected = array!["TEASER", " EASER", "  ASER", "   SER", "    ER", "     R"];

    let output = transpose(input);
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn jagged_triangle() {
    let mut input: Array<ByteArray> = array!["11", "2", "3333", "444", "555555", "66666"];
    let expected = array!["123456", "1 3456", "  3456", "  3 56", "    56", "    5 "];

    let output = transpose(input);
    assert_eq!(output, expected);
}
