# Hints

## General

- Remember that operator overloading is implemented through traits in Cairo
- The `#[derive(PartialEq)]` attribute automatically implements equality comparison
- When implementing `PartialOrd`, you only need to implement the `lt` method; the other comparison operators are derived from it

## 1. Implementing `Add`

- The `add` method should combine the `value` fields of both TimeShards
- Remember that TimeShards contain `i32` values which already have addition defined

## 2. Implementing `Sub`

- Similar to addition, but uses the subtraction operator between the `value` fields
- The order of operands matters in subtraction

## 3. Implementing `PartialOrd`

- The `lt` method should compare the `value` fields of the TimeShards
- Once `lt` is implemented, the other comparison operators (`>`, `<=`, `>=`) will work automatically
- Remember that `PartialEq` is already derived, so you don't need to implement it manually
