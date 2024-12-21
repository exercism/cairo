# Hints

## General

- [The Cairo Book: Smart Pointers][smart-pointers]

## 1. Build the ChronoChain from an array of `u32` values

- We can iterate through the array and construct a chain in reverse, starting from the `End` and linking each value with the `Link` variant.
- Consider using `span.pop_back()` to iterate through the array in reverse order, this will help us create the chain from the end to the start.

## 2. Sum the values in the ChronoChain

- Use pattern matching to handle the two variants of `ChronoChain`.
- When you reach `End`, the sum is 0, and when you reach `Link`, you add the value and recursively sum the rest of the chain.
- This approach is similar to a recursive function that traverses the structure until it reaches the base case (`End`).

[smart-pointers]: https://book.cairo-lang.org/ch11-02-smart-pointers.html
