use proverb::recite;

#[test]
fn zero_pieces() {
    let input: Array<ByteArray> = array![];
    let output = recite(@input);
    let expected: ByteArray = "";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn one_piece() {
    let input: Array<ByteArray> = array!["nail"];
    let output = recite(@input);
    let expected: ByteArray = "And all for the want of a nail.";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn two_pieces() {
    let input: Array<ByteArray> = array!["nail", "shoe"];
    let output = recite(@input);
    let expected: ByteArray =
        "For want of a nail the shoe was lost.\nAnd all for the want of a nail.";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn three_pieces() {
    let input: Array<ByteArray> = array!["nail", "shoe", "horse"];
    let output = recite(@input);
    let expected: ByteArray =
        "For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nAnd all for the want of a nail.";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn full_proverb() {
    let input: Array<ByteArray> = array![
        "nail", "shoe", "horse", "rider", "message", "battle", "kingdom",
    ];
    let output = recite(@input);
    let expected: ByteArray =
        "For want of a nail the shoe was lost.\nFor want of a shoe the horse was lost.\nFor want of a horse the rider was lost.\nFor want of a rider the message was lost.\nFor want of a message the battle was lost.\nFor want of a battle the kingdom was lost.\nAnd all for the want of a nail.";
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_pieces_modernized() {
    let input: Array<ByteArray> = array!["pin", "gun", "soldier", "battle"];
    let output = recite(@input);
    let expected: ByteArray =
        "For want of a pin the gun was lost.\nFor want of a gun the soldier was lost.\nFor want of a soldier the battle was lost.\nAnd all for the want of a pin.";
    assert_eq!(output, expected);
}
