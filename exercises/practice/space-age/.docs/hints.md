# Hints

## General

- [The Cairo Book: Data Types][data-types]
- [The Cairo Book: Default Trait Implementations][default-implementation]
- [The Cairo Book: Associated Constants][associated-constants]

## 1. Set each planet's `const PERIOD` to its appropriate value

- Remember, there are not floating point numbers in Cairo!

## 2. Write the default implementation for function `Planet::age`

- All planets use the same age calculation algorithm, only their `const PERIOD` differs.
- The `age` method default implementation will automatically apply to all planets.
- Pay close attention to how you represent decimal values.

[data-types]: https://book.cairo-lang.org/ch02-02-data-types.html
[default-implementation]: https://book.cairo-lang.org/ch08-02-traits-in-cairo.html?highlight=default#default-implementations
[associated-constants]: https://book.cairo-lang.org/ch11-10-associated-items.html?highlight=const#associated-constants
