# Mutability

Cairo, with its blockchain-oriented design, implements an immutable memory model by default. This means that once a value is written into memory, it cannot be overwritten, only read. However, Cairo provides a mechanism to create mutable variables using the `mut` keyword. When a variable is declared as mutable, and the value is changed, the new value is written to a new memory cell, and the variable is updated to point to the new cell. This mechanism allows for flexibility while maintaining the benefits of immutability.

## Declaring Immutable and Mutable Variables

```rust
let x = 5;
x = 2; // Error: cannot assign twice to immutable variable
```

In the example below, `x` is declared as an immutable variable. When the value of `x` is changed, the compiler will throw an error because the variable is immutable.

```rust
let mut x = 5;
x = 10;
```

We can declare `x` as a mutable variable using the `mut` keyword. This allows the value of `x` to be changed after it is declared.


Ultimately, deciding whether to use mutability or not is up to you and depends on what you think is clearest in that particular situation.
