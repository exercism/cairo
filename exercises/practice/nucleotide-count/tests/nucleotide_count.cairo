use nucleotide_count::{Counter, counts};

#[test]
fn empty_strand() {
    let strand = "";
    let output = counts(strand);
    let expected = Counter { a: 0, c: 0, g: 0, t: 0 };
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn can_count_one_nucleotide_in_single_character_input() {
    let strand = "G";
    let output = counts(strand);
    let expected = Counter { a: 0, c: 0, g: 1, t: 0 };
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn strand_with_repeated_nucleotide() {
    let strand = "GGGGGGG";
    let output = counts(strand);
    let expected = Counter { a: 0, c: 0, g: 7, t: 0 };
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn strand_with_multiple_nucleotides() {
    let strand = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC";
    let output = counts(strand);
    let expected = Counter { a: 20, c: 12, g: 17, t: 21 };
    assert_eq!(output, expected);
}

#[test]
#[ignore]
#[should_panic(expected: ("Invalid nucleotide in strand",))]
fn strand_with_invalid_nucleotides() {
    counts("AGXXACT");
}
