pub fn square(s: u8) -> u64 {
    assert!(1 <= s && s <= 64, "square must be between 1 and 64");
    pow(2, s - 1)
}

pub fn total() -> u64 {
    let mut result = 0;
    for s in 1..65_u8 {
        result += square(s);
    };
    result
}

fn pow(base: u8, mut power: u8) -> u64 {
    if base == 0 {
        return base.into();
    }
    let base: u64 = base.into();
    let mut result = 1_u64;
    while power != 0 {
        result *= base;
        power -= 1;
    };
    result.try_into().expect('too large to fit output type')
}
