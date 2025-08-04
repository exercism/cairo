use core::dict::Felt252Dict;
use core::nullable::{FromNullableResult, match_nullable};

pub fn transform(legacy: Felt252Dict<Nullable<Span<u8>>>) -> Felt252Dict<u32> {
    let mut legacy = legacy;
    let mut result: Felt252Dict<u32> = Default::default();
    for point in 1..11_u32 {
        let letters = legacy.get(point.into());
        let letters = match match_nullable(letters) {
            FromNullableResult::NotNull(v) => v.unbox(),
            FromNullableResult::Null => array![].span(),
        };
        for letter in letters {
            result.insert(lowercase(letter).into(), point);
        }
    }
    result
}

fn lowercase(upper: @u8) -> u8 {
    *upper + 32
}
