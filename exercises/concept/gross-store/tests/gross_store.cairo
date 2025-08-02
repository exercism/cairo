use core::dict::Felt252Dict;
use gross_store::*;

#[test]
#[ignore]
fn test_units() {
    let mut units = units();

    assert!(units.get('quarter_of_a_dozen') == 3, "quarter_of_a_dozen should be 3");
    assert!(units.get('half_of_a_dozen') == 6, "half_of_a_dozen should be 6");
    assert!(units.get('dozen') == 12, "dozen should be 12");
    assert!(units.get('small_gross') == 120, "small_gross should be 120");
    assert!(units.get('gross') == 144, "gross should be 144");
    assert!(units.get('great_gross') == 1728, "great_gross should be 1728");
}

#[test]
#[ignore]
fn test_add_item_invalid_unit() {
    let mut bill = new_bill();
    let mut units = units();

    let ok = add_item(ref bill, ref units, 'pasta', '');
    assert!(!ok, "Should fail with empty unit");

    let ok = add_item(ref bill, ref units, 'onion', 'quarter');
    assert!(!ok, "Should fail with invalid unit");

    let ok = add_item(ref bill, ref units, 'pasta', 'pound');
    assert!(!ok, "Should fail with invalid unit");
}

#[test]
#[ignore]
fn test_add_item_valid_unit() {
    let mut bill = new_bill();
    let mut units = units();

    let ok = add_item(ref bill, ref units, 'peas', 'quarter_of_a_dozen');
    assert!(ok, "Should add peas");
    assert!(bill.get('peas') == 3, "peas quantity should be 3");

    let ok = add_item(ref bill, ref units, 'tomato', 'half_of_a_dozen');
    assert!(ok, "Should add tomato");
    assert!(bill.get('tomato') == 6, "tomato quantity should be 6");

    let ok = add_item(ref bill, ref units, 'chili', 'dozen');
    assert!(ok, "Should add chili");
    assert!(bill.get('chili') == 12, "chili quantity should be 12");

    let ok = add_item(ref bill, ref units, 'cucumber', 'small_gross');
    assert!(ok, "Should add cucumber");
    assert!(bill.get('cucumber') == 120, "cucumber quantity should be 120");

    let ok = add_item(ref bill, ref units, 'potato', 'gross');
    assert!(ok, "Should add potato");
    assert!(bill.get('potato') == 144, "potato quantity should be 144");

    let ok = add_item(ref bill, ref units, 'zucchini', 'great_gross');
    assert!(ok, "Should add zucchini");
    assert!(bill.get('zucchini') == 1728, "zucchini quantity should be 1728");
}

#[test]
#[ignore]
fn test_add_item_twice() {
    let mut bill = new_bill();
    let mut units = units();

    // Add peas once
    let ok = add_item(ref bill, ref units, 'peas', 'quarter_of_a_dozen');
    assert!(ok, "Should add peas");
    assert!(bill.get('peas') == 3, "peas quantity should be 3");

    // Add peas again
    let ok = add_item(ref bill, ref units, 'peas', 'quarter_of_a_dozen');
    assert!(ok, "Should add peas again");
    assert!(bill.get('peas') == 6, "peas quantity should be 6");

    // Add tomato
    let ok = add_item(ref bill, ref units, 'tomato', 'half_of_a_dozen');
    assert!(ok, "Should add tomato");
    assert!(bill.get('tomato') == 6, "tomato quantity should be 6");

    // Add tomato with different unit
    let ok = add_item(ref bill, ref units, 'tomato', 'quarter_of_a_dozen');
    assert!(ok, "Should add tomato again");
    assert!(bill.get('tomato') == 9, "tomato quantity should be 9");
}

#[test]
#[ignore]
fn test_remove_item_not_found() {
    let mut bill = setup_initial_bill_data();
    let mut units = units();

    // Item not found in bill
    let ok = remove_item(ref bill, ref units, 'papaya', 'gross');
    assert!(!ok, "Should fail for non-existent item");
}

#[test]
#[ignore]
fn test_remove_item_invalid_unit() {
    let mut bill = setup_initial_bill_data();
    let mut units = units();

    // Invalid measurement unit
    let ok = remove_item(ref bill, ref units, 'peas', 'pound');
    assert!(!ok, "Should fail with invalid unit");

    let ok = remove_item(ref bill, ref units, 'tomato', 'kilogram');
    assert!(!ok, "Should fail with invalid unit");

    let ok = remove_item(ref bill, ref units, 'cucumber', 'stone');
    assert!(!ok, "Should fail with invalid unit");

    // Check that the bill items remain unchanged
    assert!(bill.get('peas') == 3, "peas quantity should still be 3");
    assert!(bill.get('tomato') == 6, "tomato quantity should still be 6");
    assert!(bill.get('cucumber') == 120, "cucumber quantity should still be 120");
}

#[test]
#[ignore]
fn test_remove_item_negative_qty() {
    let mut bill = setup_initial_bill_data();
    let mut units = units();

    // Resulted qty less than 0
    let ok = remove_item(ref bill, ref units, 'peas', 'half_of_a_dozen');
    assert!(!ok, "Should fail when result is negative");

    let ok = remove_item(ref bill, ref units, 'tomato', 'dozen');
    assert!(!ok, "Should fail when result is negative");

    let ok = remove_item(ref bill, ref units, 'chili', 'small_gross');
    assert!(!ok, "Should fail when result is negative");

    let ok = remove_item(ref bill, ref units, 'cucumber', 'gross');
    assert!(!ok, "Should fail when result is negative");

    let ok = remove_item(ref bill, ref units, 'potato', 'great_gross');
    assert!(!ok, "Should fail when result is negative");

    // Check that the bill items remain unchanged
    assert!(bill.get('peas') == 3, "peas quantity should still be 3");
    assert!(bill.get('tomato') == 6, "tomato quantity should still be 6");
    assert!(bill.get('chili') == 12, "chili quantity should still be 12");
    assert!(bill.get('cucumber') == 120, "cucumber quantity should still be 120");
    assert!(bill.get('potato') == 144, "potato quantity should still be 144");
}

#[test]
#[ignore]
fn test_remove_item_to_zero() {
    let mut bill = setup_initial_bill_data();
    let mut units = units();

    // Should delete the item if result is 0
    let ok = remove_item(ref bill, ref units, 'peas', 'quarter_of_a_dozen');
    assert!(ok, "Should remove peas");
    assert!(bill.get('peas') == 0, "peas should be deleted");

    let ok = remove_item(ref bill, ref units, 'tomato', 'half_of_a_dozen');
    assert!(ok, "Should remove tomato");
    assert!(bill.get('tomato') == 0, "tomato should be deleted");

    let ok = remove_item(ref bill, ref units, 'chili', 'dozen');
    assert!(ok, "Should remove chili");
    assert!(bill.get('chili') == 0, "chili should be deleted");

    let ok = remove_item(ref bill, ref units, 'cucumber', 'small_gross');
    assert!(ok, "Should remove cucumber");
    assert!(bill.get('cucumber') == 0, "cucumber should be deleted");

    let ok = remove_item(ref bill, ref units, 'potato', 'gross');
    assert!(ok, "Should remove potato");
    assert!(bill.get('potato') == 0, "potato should be deleted");

    let ok = remove_item(ref bill, ref units, 'zucchini', 'great_gross');
    assert!(ok, "Should remove zucchini");
    assert!(bill.get('zucchini') == 0, "zucchini should be deleted");
}

#[test]
#[ignore]
fn test_remove_item_reduce_qty() {
    let mut bill = setup_initial_bill_data();
    let mut units = units();

    // Should reduce the quantity
    let ok = remove_item(ref bill, ref units, 'chili', 'half_of_a_dozen');
    assert!(ok, "Should reduce chili qty");
    assert!(bill.get('chili') == 6, "chili quantity should be 6");

    let ok = remove_item(ref bill, ref units, 'cucumber', 'dozen');
    assert!(ok, "Should reduce cucumber qty");
    assert!(bill.get('cucumber') == 108, "cucumber quantity should be 108");

    let ok = remove_item(ref bill, ref units, 'zucchini', 'gross');
    assert!(ok, "Should reduce zucchini qty");
    assert!(bill.get('zucchini') == 1584, "zucchini quantity should be 1584");
}

#[test]
#[ignore]
fn test_get_item_not_found() {
    let mut bill = setup_initial_bill_data();

    // Item not found in bill
    let qty = get_item(ref bill, 'grape');
    assert!(qty == 0, "Quantity should be 0 for not found");
}

#[test]
#[ignore]
fn test_get_item_success() {
    let mut bill = setup_initial_bill_data();

    // Success cases
    let qty = get_item(ref bill, 'peas');
    assert!(qty == 3, "peas quantity should be 3");

    let qty = get_item(ref bill, 'tomato');
    assert!(qty == 6, "tomato quantity should be 6");

    let qty = get_item(ref bill, 'chili');
    assert!(qty == 12, "chili quantity should be 12");

    let qty = get_item(ref bill, 'cucumber');
    assert!(qty == 120, "cucumber quantity should be 120");

    let qty = get_item(ref bill, 'potato');
    assert!(qty == 144, "potato quantity should be 144");

    let qty = get_item(ref bill, 'zucchini');
    assert!(qty == 1728, "zucchini quantity should be 1728");
}

fn setup_initial_bill_data() -> Felt252Dict<u32> {
    let mut bill = new_bill();
    bill.insert('peas', 3);
    bill.insert('tomato', 6);
    bill.insert('chili', 12);
    bill.insert('cucumber', 120);
    bill.insert('potato', 144);
    bill.insert('zucchini', 1728);
    bill
}
