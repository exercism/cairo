# Mutability

Cairo, with its blockchain-oriented design, implements an immutable memory model by default. This means that once a value is written into memory, it cannot be overwritten, only read. However, Cairo provides a mechanism to create mutable variables using the `mut` keyword. When a variable is declared as mutable, and the value is changed, the new value is written to a new memory cell, and the variable is updated to point to the new cell. This mechanism allows for flexibility while maintaining the benefits of immutability.

In the example below, `x` is declared as an immutable variable. If the value of `x` is changed, the compiler will throw an error.

```rust
let x = 5;
x = 2; // Error: cannot assign twice to immutable variable
```

We can declare `x` as a mutable variable using the `mut` keyword. This allows the value of `x` to be changed after it is declared.

```rust
let mut x = 5;
x = 10;
```

Ultimately, deciding whether to use mutability or not is up to you and depends on what you think is clearest in that particular situation.

## Constants

Like immutable variables, constants are values that are bound to a name and are not allowed to change, but there are a few differences between constants and variables:

- Constants are declared using the `const` keyword
- You aren't allowed to use `mut` with constants
- Type of the value must always be explicitly set
- Constants can only be declared in the global scope
- Constants may be set only to constant expressions, not the result of a value computed at runtime

```rust
struct AnyStruct {
    a: u256,
    b: u32
}

enum AnyEnum {
    A: felt252,
    B: (usize, u256)
}

const ONE_HOUR_IN_SECONDS: u32 = 3600;
const STRUCT_INSTANCE: AnyStruct = AnyStruct { a: 0, b: 1 };
const ENUM_INSTANCE: AnyEnum = AnyEnum::A('any enum');
const BOOL_FIXED_SIZE_ARRAY: [bool; 2] = [true, false];
```

It is possible to use the `consteval_int!` macro to create a `const` variable that is the result of some computation.

```rust
const ONE_HOUR_IN_SECONDS: u32 = consteval_int!(60 * 60);
```

## Shadowing

It's possible, and often idiomatic, to reuse a variable name as a particular value is transformed, by re-declaring it with multiple `let` invocations. This is known as _shadowing_. In effect, the second variable overshadows the first, taking any uses of the variable name to itself until either it itself is shadowed or the scope ends.

```rust
fn main() {
    let s: ByteArray = "my string";
    let s: ByteArray = s + " and a shadow";
    {
        let s: ByteArray = "a nested shadow";
        println!(s);                           // emits "a nested shadow"
    }
    println!(s);                               // emits "my string and a shadow"
}
```

Using shadowing, we can even change the type of the variable, while reusing the same variable name.

```rust
fn main() {
    let x: u64 = 2;
    println!("x is u64, value: {}", x);               // prints "x is u64, value: 2"
    let x: ByteArray = format!("fizz");               // converts x to a ByteArray, type annotation is required
    println!("x is now ByteArray, value: \"{}\"", x); // prints 'x is now ByteArray, value: "fizz"'
}
```
