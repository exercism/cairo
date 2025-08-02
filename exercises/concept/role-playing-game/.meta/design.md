# Design

## Learning Objectives

- Know what the `Option` keyword refers to.
- Understand that `Option`s in Cairo are the closest analog to null pointers in other languages.
- Understand that `Option`s are commonly paired with pattern matching in order to query for the presence or absence of a value.

## Out of Scope

- Using `if let` or `while let` syntax for matching on an `Option`.
- Methods on `Option`s.

## Concepts

- Options

## Prerequisites

- Method Syntax

## Resources to Refer to

### Hints

- [The `Option` type in The Cairo Book][book]
- [The Billion-Dollar Mistake][nil]

[book]: https://www.starknet.io/cairo-book/ch06-01-enums.html#the-option-enum-and-its-advantages
[nil]: https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/

### After

Take a look at the list of methods implemented on the `Option` type in the [source code][source].

Some commonly used methods on `Option`s include:

- `is_some` to check if an `Option` is of the `Some` variant
- `is_none` to check if an `Option` is of the `None` variant
- `map` in order to apply function to a value contained in an `Option`
- `take` in order to replace an `Option` with a `None`; useful when needing to swap two values

[source]: https://github.com/starkware-libs/cairo/blob/44eed82c5a0b2e57e4f76ac0925cc237d43bd877/corelib/src/option.cairo
