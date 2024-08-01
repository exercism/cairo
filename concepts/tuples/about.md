# The Tuple Type

A tuple is a versatile and efficient compound data type in Cairo, allowing you to group multiple values of different types into a single entity. Tuples have a fixed length, meaning once they are declared, their size cannot change.

## Creating Tuples

To create a tuple, you write a comma-separated list of values inside parentheses. Each position in the tuple has a specific type, and these types can differ from one another. Here’s an example with optional type annotations:

```rust
fn main() {
    let tup: (u32, u64, bool) = (10, 20, true);
}
```

In this example, the variable `tup` binds to the entire tuple, treating it as a single compound element.

## Destructuring Tuples

To access the individual values within a tuple, you can use pattern matching to destructure the tuple. This breaks the tuple into its constituent parts. For example:

```rust
fn main() {
    let tup = (500, 6, true);

    let (x, y, z) = tup;

    if y == 6 {
        println!("y is 6!");
    }
}
```

This code creates a tuple and binds it to the variable `tup`. Using a `let` pattern, it destructures `tup` into three separate variables: `x`, `y`, and `z`. The program then checks if `y` is 6 and prints a corresponding message.

## Declaring and Destructuring Simultaneously

You can also declare and destructure a tuple simultaneously:

```rust
fn main() {
    let (x, y): (felt252, felt252) = (2, 3);
}
```

## The Unit Type `()`

The unit type is a special type in Cairo that has only one value: `()`. It is represented by a tuple with no elements. The size of the unit type is always zero, and it is guaranteed not to exist in the compiled code.

In Cairo, every expression returns a value, and when an expression returns nothing, it implicitly returns `()`. This can be useful for functions that need to return a value but have no meaningful value to return.

## Summary

Tuples are a fundamental compound data type in Cairo, providing an efficient way to group related data of different types. Their immutability and fixed length ensure that once created, tuples offer a reliable structure for managing complex data sets.
