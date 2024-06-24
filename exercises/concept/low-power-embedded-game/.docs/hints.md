# Hints

## General

- [The Cairo Book: The Tuple Type](https://book.cairo-lang.org/ch02-02-data-types.html?highlight=tuple#the-tuple-type)
- [Starknet By Example: Tuples](https://starknet-by-example.voyager.online/getting-started/cairo_cheatsheet/tuples.html)

## 1. Write a function `divmod` which returns the quotient and remainder of a division

- Don't worry about optimizing for efficiency; the naive implementation is fine

## 2. Write an iterator adaptor `evens` which returns the even items from an arbitrary iterator

- Just chain together the suggested methods and everything will work out
- A number `n` is even if `n % 2 == 0`
- A closure is a function with abbreviated syntax: the argument name(s) go
  within a pair of `|` symbols, and the expression follows. Unlike normal
  functions, it is not always necessary to explicitly state the type of each
  argument, just the name. For example, here is how you can construct an iterator
  of odd squares: `(0..).map(|n| 2 * n + 1).map(|n| n * n)`.

## 3. Implement a `manhattan` method on a `Position` tuple struct

- Don't worry about method syntax; just replacing the `todo` portion within the
  `impl Position` block will do the right thing.
- Consider that some values within a `Position` may be negative, but a distance
  is never negative.
- Calculating the absolute value will be supported natively in Cairo at some
  point, we provided a helper trait you can use in the meantime
