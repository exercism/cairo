use eliuds_eggs::eggCount;

#[test]
#[ignore]
fn zero_eggs() {
    let output = eggCount(0);
    let expected = 0;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn one_egg() {
    let output = eggCount(16);
    let expected = 1;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn four_eggs() {
    let output = eggCount(89);
    let expected = 4;
    assert_eq!(output, expected);
}

#[test]
#[ignore]
fn thirteen_eggs() {
    let output = eggCount(2000000000);
    let expected = 13;
    assert_eq!(output, expected);
}
