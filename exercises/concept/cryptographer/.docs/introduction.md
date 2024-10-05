# Introduction

In Cairo, one of the core concepts you'll encounter is the `felt252` type, also known as a **field element**.
This type represents integers within a specific range defined by a large prime number $P$.
In this exercise, you'll work exclusively with the `felt252` type, which is an essential part of Cairo programming.

The `felt252` type in Cairo is a scalar type used to represent integers from 0 up to $P - 1$, where $P$ is a large prime number currently set to $( 2^{251} + 17 \cdot 2^{192} + 1 )$.
This type ensures that all arithmetic operations are performed modulo $P$, making it different from standard integer types you might encounter in other programming languages.

Cairo provides support for basic arithmetic operations on `felt252` values:

- **Addition (`+`)**: Adds two `felt252` values.
  If the result exceeds $P$, it's reduced modulo $P$.
- **Subtraction (`-`)**: Subtracts one `felt252` value from another.
  If the result is negative, it's adjusted to stay within the range by adding a multiple of $P$.
- **Multiplication (`*`)**: Multiplies two `felt252` values, with the result computed modulo $P$.
- **Division (`/`)**: Divides one `felt252` value by another, ensuring the result satisfies the equation $( \frac{x}{y} \cdot y = x \mod P)$.
