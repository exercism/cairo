# Instructions

In this exercise, you'll be assisting a cryptographer in managing and verifying a secure communication system.
The system relies heavily on field elements, specifically the `felt252` type in Cairo, to ensure that all arithmetic operations remain within a defined range.

## 1. Calculate the Sum of Two Messages

Two encrypted messages, each represented as a `felt252`, need to be added together to create a combined message.
However, because of the encryption, any result that exceeds the maximum value $P - 1$ must be wrapped around using modulo $P$.

Implement a function that takes in two `felt252` values and returns their sum, ensuring the result stays within the valid range:

```rust
add_messages(3618502788666131213697322783095070105623107215331596699973092056135007822949, 987654321)
// => 123456789
```

> **Note:** The return value should be a `felt252`.

## 2. Calculate the Difference Between Two Messages

Sometimes, messages need to be subtracted to retrieve the original data.
If the result of the subtraction is negative, the system automatically adjusts the result by adding $P$ to bring it back within the range of a valid `felt252` value.

Implement a function that takes in two `felt252` values and returns their difference, ensuring the result stays within the valid range:

```rust
subtract_messages(123456789, 987654321)
// => 3618502788666131213697322783095070105623107215331596699973092056135007822949
```

> **Note:** The return value should be a `felt252`.

## 3. Calculate a Valid Product of Two Messages

To ensure the integrity of encrypted data, the cryptographic system often multiplies two messages (`felt252`) to ensure their product stays within a valid range.
The result must be computed modulo $P$ to ensure it remains within the valid range.

Implement a function that takes in two `felt252` values and returns their product, ensuring the result stays within the valid range:

```rust
multiply_messages(382927772233671078546147897004315551461400594453673204174697055647611, 9449570)
// => 123456789
```

> **Note:** The return value should be a `felt252`.
