use bakery_order_system::{Pastry, apply_discount, baking_schedule, calculate_total};

#[test]
fn test_calculate_croissant_total() {
    assert_eq!(calculate_total(Pastry::Croissant, 4), 12);
    assert_eq!(calculate_total(Pastry::Croissant, 1), 3);
}

#[test]
#[ignore]
fn test_calculate_muffin_total() {
    assert_eq!(calculate_total(Pastry::Muffin, 5), 10);
    assert_eq!(calculate_total(Pastry::Muffin, 3), 6);
}

#[test]
#[ignore]
fn test_calculate_cookie_total() {
    assert_eq!(calculate_total(Pastry::Cookie, 10), 10);
    assert_eq!(calculate_total(Pastry::Cookie, 7), 7);
}

#[test]
#[ignore]
fn test_no_discount() {
    assert_eq!(apply_discount(5), 5);
    assert_eq!(apply_discount(9), 9);
}

#[test]
#[ignore]
fn test_five_percent_discount() {
    assert_eq!(apply_discount(10), 9); // 10 * 0.95 = 9.5, rounded down to 9
    assert_eq!(apply_discount(15), 14); // 15 * 0.95 = 14.25, rounded down to 14
    assert_eq!(apply_discount(19), 18); // 19 * 0.95 = 18.05, rounded down to 18
}

#[test]
#[ignore]
fn test_ten_percent_discount() {
    assert_eq!(apply_discount(20), 18); // 20 * 0.9 = 18
    assert_eq!(apply_discount(25), 22); // 25 * 0.9 = 22.5, rounded down to 22
    assert_eq!(apply_discount(30), 27); // 30 * 0.9 = 27
}

#[test]
#[ignore]
fn test_baking_schedule_multiple_batches() {
    let result = baking_schedule(18);
    let expected = [5, 5, 5, 3].span();

    assert_eq!(result.len(), 4);
    assert_eq!(result.span(), expected);
}

#[test]
#[ignore]
fn test_baking_schedule_exact_batches() {
    let result = baking_schedule(10);
    let expected = [5, 5].span();

    assert_eq!(result.len(), 2);
    assert_eq!(result.span(), expected);
}

#[test]
#[ignore]
fn test_baking_schedule_single_partial_batch() {
    let result = baking_schedule(3);
    let expected = [3].span();

    assert_eq!(result.len(), 1);
    assert_eq!(result.span(), expected);
}

#[test]
#[ignore]
fn test_baking_schedule_zero_orders() {
    let result = baking_schedule(0);
    assert_eq!(result.len(), 0);
}
