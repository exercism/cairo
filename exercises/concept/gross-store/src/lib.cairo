use core::dict::Felt252Dict;

pub fn units() -> Felt252Dict<u32> {
    panic!("implement `units`")
}

pub fn new_bill() -> Felt252Dict<u32> {
    panic!("implement `new_bill`")
}

pub fn add_item(
    ref bill: Felt252Dict<u32>, ref units: Felt252Dict<u32>, item: felt252, unit: felt252,
) -> bool {
    panic!("implement `add_item`")
}

pub fn remove_item(
    ref bill: Felt252Dict<u32>, ref units: Felt252Dict<u32>, item: felt252, unit: felt252,
) -> bool {
    panic!("implement `remove_item`")
}

pub fn get_item(ref bill: Felt252Dict<u32>, item: felt252) -> u32 {
    panic!("implement `get_item`")
}

