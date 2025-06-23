use core::num::traits::Pow;

pub fn square(s: u8) -> u64 {
    assert!(1 <= s && s <= 64, "square must be between 1 and 64");
    2_u64.pow(s.into() - 1)
}

pub fn total() -> u64 {
    let mut result = 0;
    for s in 1..65_u8 {
        result += square(s);
    };
    result
}
