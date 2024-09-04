use hamming::distance;

#[test]
fn empty_strands() {
    let output = distance("", "");
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn single_letter_identical_strands() {
    let output = distance("A", "A");
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn single_letter_different_strands() {
    let output = distance("G", "T");
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn long_identical_strands() {
    let output = distance("GGACTGAAATCTG", "GGACTGAAATCTG");
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn long_different_strands() {
    let output = distance("GGACGGATTCTG", "AGGACGGATTCT");
    let expected = 9;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("strands must be of equal length",))]
fn disallow_first_strand_longer() {
    distance("AATG", "AAA");
}

#[test]
#[ignore]
#[should_panic(expected: ("strands must be of equal length",))]
fn disallow_second_strand_longer() {
    distance("ATA", "AGTG");
}

#[test]
#[ignore]
#[should_panic(expected: ("strands must be of equal length",))]
fn disallow_empty_first_strand() {
    distance("", "G");
}

#[test]
#[ignore]
#[should_panic(expected: ("strands must be of equal length",))]
fn disallow_empty_second_strand() {
    distance("G", "");
}
