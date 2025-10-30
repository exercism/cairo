use atbash_cipher::{decode, encode};

// Encode tests

#[test]
fn encode_yes() {
    let phrase = "yes";
    let output = encode(phrase);
    let expected = "bvh";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_no() {
    let phrase = "no";
    let output = encode(phrase);
    let expected = "ml";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_omg() {
    let phrase = "OMG";
    let output = encode(phrase);
    let expected = "lnt";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_spaces() {
    let phrase = "O M G";
    let output = encode(phrase);
    let expected = "lnt";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_mindblowingly() {
    let phrase = "mindblowingly";
    let output = encode(phrase);
    let expected = "nrmwy oldrm tob";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_numbers() {
    let phrase = "Testing, 1 2 3, testing.";
    let output = encode(phrase);
    let expected = "gvhgr mt123 gvhgr mt";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_deep_thought() {
    let phrase = "Truth is fiction.";
    let output = encode(phrase);
    let expected = "gifgs rhurx grlm";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn encode_all_the_letters() {
    let phrase = "The quick brown fox jumps over the lazy dog.";
    let output = encode(phrase);
    let expected = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt";
    assert_eq!(expected, output);
}

// Decode tests

#[test]
#[ignore]
fn decode_exercism() {
    let phrase = "vcvix rhn";
    let output = decode(phrase);
    let expected = "exercism";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn decode_a_sentence() {
    let phrase = "zmlyh gzxov rhlug vmzhg vkkrm thglm v";
    let output = decode(phrase);
    let expected = "anobstacleisoftenasteppingstone";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn decode_numbers() {
    let phrase = "gvhgr mt123 gvhgr mt";
    let output = decode(phrase);
    let expected = "testing123testing";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn decode_all_the_letters() {
    let phrase = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt";
    let output = decode(phrase);
    let expected = "thequickbrownfoxjumpsoverthelazydog";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn decode_with_too_many_spaces() {
    let phrase = "vc vix    r hn";
    let output = decode(phrase);
    let expected = "exercism";
    assert_eq!(expected, output);
}

#[test]
#[ignore]
fn decode_with_no_spaces() {
    let phrase = "zmlyhgzxovrhlugvmzhgvkkrmthglmv";
    let output = decode(phrase);
    let expected = "anobstacleisoftenasteppingstone";
    assert_eq!(expected, output);
}
