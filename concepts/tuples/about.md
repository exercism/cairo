# The Tuple Type

A tuple is a versatile and efficient compound data type in Cairo, allowing you to group multiple values of different types into a single entity. Tuples have a fixed length, meaning once they are declared, their size cannot change.

## Creating Tuples

To create a tuple, you write a comma-separated list of values inside parentheses. Each position in the tuple has a specific type, and these types can differ from one another.

```rust
fn main() {
    let tup: (u32, u64, bool) = (10, 20, true);
}
```

A tuple can hold multiple values of different data types, including other tuples. For example:

```rust
fn main() {
    let nested_tup: ((i32, f64), (u8, bool)) = ((10, 3.14), (5, false));
}
```

Here, `nested_tup` varibale is a tuple containing two tuples, demonstrating that tuples can hold other tuples as elements.

## Destructuring Tuples

To access the individual values within a tuple, you can use pattern matching to destructure the tuple. This breaks the tuple into its constituent parts.

```rust
fn main() {
    let tup = (500, 6, true);

    let (x, y, z) = tup;

    println!("x is: {x}"); // prints "x is: 500"
    println!("y is: {y}"); // prints "x is: 6"
    println!("z is: {z}"); // prints "z is: true"
}
```

## Declaring and Destructuring Simultaneously

You can also declare and destructure a tuple simultaneously.

```rust
fn main() {
    let (x, y): (felt252, felt252) = (2, 3);
}
```

## The Unit Type `()`

The unit type is a special type in Cairo that has only one value: `()`. It is represented by a tuple with no elements. The size of the unit type is always zero, and it is guaranteed not to exist in the compiled code.

In Cairo, every expression returns a value, and when an expression returns nothing, it implicitly returns `()`. This can be useful for functions that need to return a value but have no meaningful value to return.

## Named Tuple Type Declaration

A named tuple allows you to create a more descriptive type alias for a tuple, improving code readability.

```rust
type Point = (u32, u32);

fn main() {
    let point: Point = (10, 8);
    println!("{point:?}"); // prints "(10, 8)"
}
```

In this example, `Point` is a named tuple type representing a pair of unsigned 32-bit integers, making the code more expressive.
