/// Types of pastries available in the bakery
#[derive(Drop, PartialEq)]
pub enum Pastry {
    Croissant,
    Muffin,
    Cookie,
}

/// Calculate the total cost of an order
pub fn calculate_total(pastry: Pastry, quantity: u32) -> u32 {
    // Croissant: 3 coins, Muffin: 2 coins, Cookie: 1 coin
    // Return total cost for the given quantity
    panic!("implement `calculate_total`")
}

/// Apply discount based on order size
pub fn apply_discount(total: u32) -> u32 {
    // Orders >= 20 coins: 10% discount
    // Orders >= 10 coins: 5% discount
    // Orders < 10 coins: no discount
    panic!("implement `apply_discount`")
}

/// Generate the daily baking schedule
pub fn baking_schedule(total_orders: u32) -> Array<u32> {
    // Bake in batches of 5 orders each
    // Return an array showing how many orders are baked each hour
    // Continue until all orders are completed
    panic!("implement `baking_schedule`")
}
