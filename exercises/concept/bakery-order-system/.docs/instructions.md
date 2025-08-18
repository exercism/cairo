# Instructions

In this exercise you'll help manage a small bakery's daily operations using Cairo's control flow constructs.

## 1. Calculate Order Total

Implement `calculate_total` that calculates the cost of an order based on pastry type and quantity:

- Croissant: 3 coins each
- Muffin: 2 coins each  
- Cookie: 1 coin each

```rust
calculate_total(Pastry::Croissant, 4) // Returns: 12 (4 * 3)
calculate_total(Pastry::Cookie, 10)   // Returns: 10 (10 * 1)
```

## 2. Apply Volume Discounts

Implement `apply_discount` that applies discounts based on order total.
Apply the percentage discount to the total, then round down to the nearest whole coin (floor).

- Orders ≥ 20 coins: 10% discount
- Orders ≥ 10 coins: 5% discount
- Orders < 10 coins: no discount

```rust
apply_discount(25) // Returns: 22
apply_discount(15) // Returns: 14
apply_discount(8)  // Returns: 8
```

## 3. Create Baking Schedule

Implement `baking_schedule` that creates a daily baking plan.
The bakery bakes in batches of 5 orders per hour:

```rust
baking_schedule(18) // Returns: [5, 5, 5, 3] (3 full batches + 3 remaining)
baking_schedule(10) // Returns: [5, 5] (2 full batches)
baking_schedule(3)  // Returns: [3] (1 partial batch)
```

Use appropriate control flow constructs (`if`/`else`, `loop`) to solve each problem efficiently.
