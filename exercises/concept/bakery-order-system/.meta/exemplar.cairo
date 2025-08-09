#[derive(Drop, PartialEq)]
pub enum Pastry {
    Croissant,
    Muffin,
    Cookie,
}

pub fn calculate_total(pastry: Pastry, quantity: u32) -> u32 {
    let price_per_item = match pastry {
        Pastry::Croissant => 3,
        Pastry::Muffin => 2,
        Pastry::Cookie => 1,
    };

    price_per_item * quantity
}

pub fn apply_discount(total: u32) -> u32 {
    if total >= 20 {
        // 10% discount: multiply by 90, divide by 100
        (total * 90) / 100
    } else if total >= 10 {
        // 5% discount: multiply by 95, divide by 100
        (total * 95) / 100
    } else {
        // No discount
        total
    }
}

pub fn baking_schedule(total_orders: u32) -> Array<u32> {
    let mut schedule = ArrayTrait::new();
    let mut remaining_orders = total_orders;

    loop {
        if remaining_orders == 0 {
            break;
        }

        if remaining_orders >= 5 {
            schedule.append(5);
            remaining_orders -= 5;
        } else {
            schedule.append(remaining_orders);
            remaining_orders = 0;
        }
    }

    schedule
}
