use core::dict::Felt252Dict;

pub fn units() -> Felt252Dict<u32> {
    let mut units: Felt252Dict<u32> = Default::default();
    units.insert('quarter_of_a_dozen', 3);
    units.insert('half_of_a_dozen', 6);
    units.insert('dozen', 12);
    units.insert('small_gross', 120);
    units.insert('gross', 144);
    units.insert('great_gross', 1728);
    units
}

pub fn new_bill() -> Felt252Dict<u32> {
    Default::default()
}

pub fn add_item(
    ref bill: Felt252Dict<u32>, ref units: Felt252Dict<u32>, item: felt252, unit: felt252,
) -> bool {
    let measurement = units.get(unit);
    if measurement == 0 {
        return false;
    }
    let qty = bill.get(item);
    bill.insert(item, qty + measurement);
    true
}

pub fn remove_item(
    ref bill: Felt252Dict<u32>, ref units: Felt252Dict<u32>, item: felt252, unit: felt252,
) -> bool {
    let qty = bill.get(item);
    if qty == 0 {
        return false;
    }
    let measurement = units.get(unit);
    if measurement == 0 {
        return false;
    }
    if qty < measurement {
        return false;
    }
    bill.insert(item, qty - measurement);
    true
}

pub fn get_item(ref bill: Felt252Dict<u32>, item: felt252) -> u32 {
    bill.get(item)
}
