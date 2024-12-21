# Instructions

In **Chrono Realms**, Time Keepers often deal with not just trees of timelines, but **Chrono Chains**-sequences of linked **TimeNodes**, each representing a specific moment in time.
A **Chrono Chain** is a straight path of sequential moments, where each **TimeNode** connects to the next.
These **Chrono Chains** are useful when traveling through a series of specific events, as they allow Time Keepers to follow a single timeline.

However, to handle these potentially long **Chrono Chains**, Time Keepers use **Smart Pointers (Box<T>)** to safely manage and traverse these lists of moments without causing unnecessary memory duplication or overflow.
Each **TimeNode** holds a reference to the next node, forming a recursive structure.

Your task as an apprentice is to implement a **Chrono Chain** as a recursive list structure using smart pointers.

In this exercise, you will:

1. Create a recursive `ChronoChain` enum, representing a list of moments.
2. Use the `Box<T>` smart pointer to store the recursive nodes.
3. Implement a function to create a `ChronoChain` from an array of `u32` values.
4. Implement a function to traverse the `ChronoChain` and sum up the values stored in the list.

## 1. Define the Recursive `ChronoChain` Enum

Create a recursive enum `ChronoChain` with two variants:

- `End`: Represents the end of the list.
- `Link`: Contains a `u32` value and a boxed reference to the next node in the chain.

## 2. Create a Function to Build a ChronoChain

Write a function `build_chrono_chain` that takes an array of `u32` values and returns a `ChronoChain`, linking the values sequentially using smart pointers.

## 3. Implement the Sum Function

Write a function `sum_chain` to recursively traverse the `ChronoChain` and sum the values of all nodes.

## Example Usage

```rust
fn main() {
    // Create a ChronoChain from an array of values
    let chrono_chain = build_chrono_chain([10, 20, 30]);

    // Sum the values in the ChronoChain
    let total_sum = sum_chain(&chrono_chain);

    println!("Total Time Power: {}", total_sum);
}
```
