# Integer Types

An `integer` is a number without a fractional component. In Cairo, the type declaration for integers indicates the number of bits the programmer can use to store the value. Table 1 outlines the built-in integer types in Cairo, each with a specific size:

| Length   | Unsigned |
|----------|----------|
| 8-bit    | u8       |
| 16-bit   | u16      |
| 32-bit   | u32      |
| 64-bit   | u64      |
| 128-bit  | u128     |
| 256-bit  | u256     |
| 32-bit   | usize    |

##### Table 1: Integer Types in Cairo

## Details

Each integer variant in Cairo has an explicit size. These variants can be used to declare the type of an integer value based on the required storage size.

- **u8**: 8-bit unsigned integer.
- **u16**: 16-bit unsigned integer.
- **u32**: 32-bit unsigned integer.
- **u64**: 64-bit unsigned integer.
- **u128**: 128-bit unsigned integer.
- **u256**: 256-bit unsigned integer.
- **usize**: 32-bit unsigned integer (currently an alias for u32).

The `usize` type is particularly noteworthy. Although it is currently an alias for `u32`, it might play a more distinct role in the future, especially if Cairo can be compiled to MLIR (Multi-Level Intermediate Representation).

## Constraints

As these variables are unsigned, they cannot represent negative numbers. This restriction ensures that all values are non-negative, which can be beneficial in certain programming contexts, such as array indexing and memory management.

By understanding and utilizing these integer types, Cairo programmers can better manage memory and optimize performance for their specific use cases.

This code will cause the program to panic:

```rust

fn sub_u8s(x: u8, y: u8) -> u8 {
    x - y
}

fn main() {
    sub_u8s(1, 3);
}

```

All integer types mentioned previously fit into a `felt252`, except for `u256`, which needs 4 more bits to be stored. Under the hood, `u256` is essentially a struct with 2 fields:

```rust
struct u256 {
    low: u128,
    high: u128
}
```

An `integer` is a number without a fractional component. In Cairo, the type declaration for integers indicates the number of bits the programmer can use to store the value.

Unsigned integers can only represent positive numbers and the number 0 (zero), which can be beneficial in certain programming contexts, such as array indexing and memory management.

## Cairo's Support for Signed Integers

Cairo also provides support for signed integers, starting with the prefix `i`. These integers can represent both positive and negative values, with sizes ranging from `i8` to `i128`. Each signed variant can store numbers from $-2^{n-1}$ to $2^{n-1} - 1$ inclusive, where $n$ is the number of bits that variant uses.

For example, an `i8` can store numbers from $-2^7$ to $2^7 - 1$, which equals $-128$ to $127$.

| Length   | Unsigned | Signed   |
|----------|----------|----------|
| 8-bit    | u8       | i8       |
| 16-bit   | u16      | i16      |
| 32-bit   | u32      | i32      |
| 64-bit   | u64      | i64      |
| 128-bit  | u128     | i128     |
| 256-bit  | u256     | i256     |

There is also a special integer type called `usize`, which is currently just an alias for `u32`. This type might play a more distinct role in the future, once Cairo can be compiled to MLIR (Multi-Level Intermediate Representation).

## Integer Literals in Cairo

You can write integer literals in any of the forms shown in the below table. Note that number literals that can be multiple numeric types allow a type suffix, such as `57_u8`, to designate the type. It is also possible to use a visual separator `_` for number literals, in order to improve code readability.

| Numeric Literals | Example |
| ---------------- | ------- |
| Decimal          | 98222   |
| Hex              | 0xff    |
| Octal            | 0o04321 |
| Binary           | 0b01    |

##### Table 2: Integer Literals in Cairo.

So how do you know which type of integer to use? Try to estimate the max value your int can have and choose the appropriate size. The primary situation in which you’d use `usize` is when indexing some sort of collection.

## Numeric Operations

Cairo supports the basic mathematical operations you’d expect for all the integer types: addition, subtraction, multiplication, division, and remainder. Integer division truncates toward zero to the nearest integer. The following code shows how you’d use each numeric operation in a `let` statement:

```rust
fn main() {
    // addition
    let sum = 5_u128 + 10_u128;

    // subtraction
    let difference = 95_u128 - 4_u128;

    // multiplication
    let product = 4_u128 * 30_u128;

    // division
    let quotient = 56_u128 / 32_u128; // result is 1
    let quotient = 64_u128 / 32_u128; // result is 2

    // remainder
    let remainder = 43_u128 % 5_u128; // result is 3
}
```

Each expression in these statements uses a mathematical operator and evaluates to a single value, which is then bound to a variable.

List of all operators that Cairo provides can be found [here](https://book.cairo-lang.org/appendix-02-operators-and-symbols.html#operators)
