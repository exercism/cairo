# Hints

## General

- A [struct][structs] can contain multiple fields of different types.
- The [Option type][option] represents a value that can either be `Some(value)` or `None`.
- [The `match` construct][match]: how to do pattern matching in Cairo.

## 1. Implement the `revive` method

- Use [conditional statements][if-else] to check if the player's health is 0.
- You can create a new `Player` instance using [struct initialization syntax][structs].
- Use [pattern matching][match] or conditional logic to determine the mana value based on the player's level.
- Return `Option::Some(player)` for successful revival or `Option::None` when revival fails.

## 2. Implement the `cast_spell` method

- Use [pattern matching][match] on the `Option` type to handle `Some` and `None` cases for mana.
- You can use [comparison operators][operators] to check if there's sufficient mana.
- You can use the [mathematical operators][operators] for subtraction and multiplication to calculate values.
- Remember to modify the player's state (health or mana) using mutable references.

[structs]: https://www.starknet.io/cairo-book/ch05-01-defining-and-instantiating-structs.html
[option]: https://www.starknet.io/cairo-book/ch06-01-enums.html#the-option-enum-and-its-advantages
[match]: https://www.starknet.io/cairo-book/ch06-02-the-match-control-flow-construct.html
[if-else]: https://www.starknet.io/cairo-book/ch02-05-control-flow.html#if-expressions
[operators]: https://www.starknet.io/cairo-book/appendix-02-operators-and-symbols.html
