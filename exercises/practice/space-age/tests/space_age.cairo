use space_age::{age, Earth, Mercury, Venus, Mars, Jupiter, Saturn, Uranus, Neptune};

fn assert_in_delta(expected: u256, actual: u256) {
    let diff: u256 = if expected > actual {
        expected - actual
    } else {
        actual - expected
    };
    let delta: u256 = 10000;
    assert_lt!(
        diff,
        delta,
        "Your result of {actual} should be within {delta} of the expected result {expected}"
    );
}

#[test]
fn age_on_earth() {
    let seconds = 1_000_000_000;
    let output = age(Earth {}, seconds);
    let expected = 3169;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_mercury() {
    let seconds = 2_134_835_688;
    let output = age(Mercury {}, seconds);
    let expected = 28088;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_venus() {
    let seconds = 189_839_836;
    let output = age(Venus {}, seconds);
    let expected = 978;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_mars() {
    let seconds = 2_129_871_239;
    let output = age(Mars {}, seconds);
    let expected = 3588;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_jupiter() {
    let seconds = 901_876_382;
    let output = age(Jupiter {}, seconds);
    let expected = 241;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_saturn() {
    let seconds = 2_000_000_000;
    let output = age(Saturn {}, seconds);
    let expected = 215;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_uranus() {
    let seconds = 1_210_123_456;
    let output = age(Uranus {}, seconds);
    let expected = 46;
    assert_in_delta(expected, output);
}

#[test]
#[ignore]
fn age_on_neptune() {
    let seconds = 1_821_023_456;
    let output = age(Neptune {}, seconds);
    let expected = 35;
    assert_in_delta(expected, output);
}
