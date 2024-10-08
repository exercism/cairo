# Instructions append

In Cairo, where there's no native support for floating-point numbers, we represent fractional values using integers.

This approach is essential in blockchain development to maintain precision in calculations.

In this exercise, we use **fixed-point arithmetic** by converting orbital periods into microseconds.

For example, Mercury’s orbital period of `0.2408467` Earth years becomes `240,846,700` microseconds by multiplying by `1,000,000`.

To account for decimal precision, the test cases assume that the resulting age has **two decimal places**, represented as integers.

This means that an age of `31.69` years is stored as `3169` in the code.

To achieve this, we multiply by 100 before performing the division.

Here's an example:

```rust
let mercury_orbital_period = 240_846_700; // in microseconds
let age_microseconds = age_seconds * 1_000_000;
// multiplying with 100 to retain 2 decimal places
age_microseconds * 100 / mercury_orbital_period
```

By using this method, you ensure that fractional values are accurately represented as integers while maintaining the required two-decimal precision, which is crucial for the tests to pass.
