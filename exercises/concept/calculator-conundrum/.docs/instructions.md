# Instructions

In this exercise, you will be building error handling for a simple integer calculator.
The calculator should support addition, multiplication, and division operations, returning the result as a formatted string.
You will also implement error handling to address illegal operations and division by zero.

The goal is to have a working calculator that returns a string in the following format: `16 + 51 = 67`, when provided with arguments `16`, `51`, and `+`.

```rust
SimpleCalculator::calculate(16, 51, "+"); // => returns "16 + 51 = 67"

SimpleCalculator::calculate(32, 6, "*"); // => returns "32 * 6 = 192"

SimpleCalculator::calculate(512, 4, "/"); // => returns "512 / 4 = 128"
```

## 1. Implement the calculator operations

The main function for this task will be `SimpleCalculator::calculate`, which takes three arguments: two integers and a `ByteArray` representing the operation.
Implement the following operations:

- **Addition** with the `+` symbol
- **Multiplication** with the `*` symbol
- **Division** with the `/` symbol

## 2. Handle illegal operations

If the operation symbol is anything other than `+`, `*`, or `/`, the calculator should either panic or return an error:

- If the operation is an empty string, panic with a `ByteArray` error message `"Operation cannot be an empty string"`.
- For any other invalid operation, return `Result::Err("Operation is out of range")`.

```rust
SimpleCalculator::calculate(100, 10, "-"); // => returns Result::Err("Operation is out of range")

SimpleCalculator::calculate(8, 2, ""); // => panics with "Operation cannot be an empty string"
```

## 3. Handle errors when dividing by zero

When attempting to divide by `0`, the calculator should panic with an error message indicating that division by zero is not allowed.
The returned result should be a `felt252` value of `'Division by zero is not allowed'`.

```rust
SimpleCalculator::calculate(512, 0, "/"); // => panics with 'Division by zero is not allowed'
```
