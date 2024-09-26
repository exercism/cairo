# Instructions

Welcome to the world of *ChronoRealms*, a magical land where powerful Timekeepers control the flow of time. In this realm, Timekeepers manage "TimeShards," special units that can be added, subtracted, compared, and even checked for equality. Your task is to help the Timekeepers by implementing custom operators for manipulating these TimeShards.

The Timekeepers need you to create a custom struct `TimeShard` that supports the following operations:

1. **Adding and Subtracting TimeShards**: Timekeepers need to be able to add and subtract TimeShards to control the timeline.
2. **Comparing TimeShards**: Sometimes, TimeShards need to be compared to see which one is larger, or if they are equal.
3. **Checking Equality**: Timekeepers need to check if two TimeShards are identical in value.

Your mission is to implement the following traits for the `TimeShard` struct:

1. **Addition (`Add`)**: Enable adding two `TimeShard` instances together.
2. **Subtraction (`Sub`)**: Enable subtracting one `TimeShard` from another.
3. **Equality (`PartialEq`)**: Allow Timekeepers to check if two `TimeShard` instances are the same.
4. **Comparison (`PartialOrd`)**: Allow comparison of two `TimeShard` instances to see which is greater or smaller.

A `TimeShard` will be represented by a struct that holds an integer value (`i32`). Implement the necessary traits to make the Timekeepers' job easier.

```rust
let shard1 = TimeShard { value: 5 };
let shard2 = TimeShard { value: 3 };

// Adding TimeShards
let sum = shard1 + shard2; // TimeShard { value: 8 }

// Subtracting TimeShards
let difference = shard1 - shard2; // TimeShard { value: 2 }

// Checking equality
let are_equal = shard1 == shard2; // false

// Comparing TimeShards
let is_greater = shard1 > shard2; // true
```
