use space_age::{Planet, Earth, Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune};

fn assert_in_delta(expected: u256, actual: u256) {
    // absolute value of the difference
    let diff: u256 = if expected > actual {
        expected - actual
    } else {
        actual - expected
    };
    let delta: u256 = 10000; // 0.01 seconds
    if diff > delta {
        panic!(
            "Your result of {actual} should be within {delta} of the expected result {expected}",
        );
    };
}

#[test]
#[ignore]
fn age_on_earth() {
    let seconds = 1_000_000_000;
    let expected = 3169;
    assert_in_delta(Earth {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_mercury() {
    let seconds = 2_134_835_688;
    let expected = 28088;
    assert_in_delta(Mercury {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_venus() {
    let seconds = 189_839_836;
    let expected = 978;
    assert_in_delta(Venus {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_mars() {
    let seconds = 2_129_871_239;
    let expected = 3588;
    assert_in_delta(Mars {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_jupiter() {
    let seconds = 901_876_382;
    let expected = 241;
    assert_in_delta(Jupiter {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_saturn() {
    let seconds = 2_000_000_000;
    let expected = 215;
    assert_in_delta(Saturn {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_uranus() {
    let seconds = 1_210_123_456;
    let expected = 46;
    assert_in_delta(Uranus {}.age(seconds), expected);
}

#[test]
#[ignore]
fn age_on_neptune() {
    let seconds = 1_821_023_456;
    let expected = 35;
    assert_in_delta(Neptune {}.age(seconds), expected);
}
