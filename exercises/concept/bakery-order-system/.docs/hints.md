# Hints

## General

- [The Cairo Book - Control Flow][tcb-control-flow]
- [The Cairo Book - Arrays][tcb-arrays]

## 1. Calculate Order Total

- Use `match` or `if`/`else if` to handle different pastry types
- Multiply the price per pastry by the quantity
- Each pastry type has a fixed price in coins

## 2. Apply Volume Discounts

- Use `if`/`else if` to check discount tiers from highest to lowest
- Remember that discounts should be applied as integer division (rounded down)
- 10% discount means multiply by 90 and divide by 100

## 3. Create Baking Schedule

- Use a `loop` to build the schedule hour by hour
- Each hour, bake up to 5 orders (or whatever remains)
- Continue until all orders are scheduled
- Use `break` when no more orders remain

[tcb-control-flow]: https://www.starknet.io/cairo-book/ch02-05-control-flow.html
[tcb-arrays]: https://www.starknet.io/cairo-book/ch03-01-arrays.html
