# Felt Type

# Scalar Types in Cairo

Scalar types represent single values in Cairo. Cairo features three primary scalar types: **felts**, **integers**, and **booleans**. These types are similar to those in other programming languages but have unique characteristics and behaviors in Cairo.

### Felt Type

In Cairo, the default type for a variable or argument, if not explicitly specified, is a **field element**. This is represented by the keyword `felt252`. A field element is an integer within the range `0 ≤ x < `P, where `P` is a very large prime number currently equal to $2^{251} + 17 \cdot 2^{192} + 1$.

#### Arithmetic Operations

When performing arithmetic operations (addition, subtraction, multiplication) with field elements, if the result falls outside the range of the prime number `P`, an overflow or underflow occurs. To handle this, Cairo adjusts the result by adding or subtracting an appropriate multiple of `P` to bring the result back within the valid range. Essentially, this means the result is computed modulo `P`.

#### Division in Cairo

A critical distinction between integers and field elements is how division is handled. Unlike regular CPU integer division, where the result of `x` divided by `y` is defined as the integer part of the quotient (returning the floor value), Cairo ensures that the division of field elements always satisfies the equation:

$(x / y) * y = x$

This means:
- If `y` divides `x` as integers, Cairo will provide the expected result. For instance, $6 / 2$ will yield `3`.
- If `y` does not divide `x`, the result can be surprising. For example, since $2 \cdot \left(\frac{P+1}{2}\right) = P + 1 \equiv 1 \mod P$, the value of $1 / 2$ in Cairo is $(P + 1)/2$ (not `0` or `0.5`), as it satisfies the above equation:


Understanding these nuances in field element operations is crucial when working with Cairo, especially when dealing with division and ensuring your calculations remain within the valid range defined by the prime number `P`.
