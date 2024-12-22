# Printing

Printing in Cairo allows you to display messages and values to the console, making it easier to debug programs or communicate information during execution. The printing system is both versatile and straightforward, providing tools to format and output data of various types.

## Printing Basics

Cairo provides two primary macros for printing text to the console:

- **`println!`**: Prints output on a new line.
- **`print!`**: Prints output inline, without adding a new line.

Both macros take a `ByteArray` as their primary argument, which can be a simple string or a formatted string with placeholders for values.

```rust
// Printing a simple message
println!("Hello, Cairo!");

// Printing with values
let x = 10;
let y = 20;
println!("Values: x = {}, y = {}", x, y);
```

In the above example:
- `{}` placeholders are replaced by the values of `x` and `y`.
- `println!` ensures the output ends with a new line.

## Formatting Strings

Sometimes, you might need to create a formatted string without immediately printing it. The `format!` macro allows you to do this. It works similarly to `println!` but returns a `ByteArray` instead of sending output to the console.

```rust
let s1: ByteArray = "tic";
let s2: ByteArray = "tac";
let s3: ByteArray = "toe";

// Create a formatted string
let result = format!("{s1}-{s2}-{s3}");

println!("{}", result); // Output: tic-tac-toe
```

In this example:
- `format!` combines `s1`, `s2`, and `s3` into a single string, separating them with dashes (`-`).
- The resulting string can be reused or printed later.

## Printing Custom Data Types

By default, Cairo can only print basic types like integers and strings. If you try to print a custom type, such as a struct, you'll encounter an error unless the type implements the `Display` or `Debug` traits.

### Using `Display` for Custom Formatting

The `Display` trait lets you define how a custom type should be printed. Here's an example:

```rust
use core::fmt::{Display, Formatter, Error};

struct Point {
    x: u8,
    y: u8,
}

impl PointDisplay of Display<Point> {
    fn fmt(self: @Point, ref f: Formatter) -> Result<(), Error> {
        write!(f, "Point({}, {})", *self.x, *self.y)
    }
}

let p = Point { x: 3, y: 4 };
println!("{}", p); // Output: Point(3, 4)
```

In this example:
- The `fmt` function defines how the `Point` struct is converted to a printable string.
- The `write!` macro appends the formatted string to the `Formatter`.

### Debugging with `Debug`

For debugging purposes, Cairo provides the `Debug` trait. You can derive it automatically for most types, making it quick and easy to print internal details of your structs.

```rust
#[derive(Debug)]
struct Point {
    x: u8,
    y: u8,
}

let p = Point { x: 3, y: 4 };
println!("{:?}", p); // Output: Point { x: 3, y: 4 }
```

In this example:
- `#[derive(Debug)]` automatically generates the implementation for the `Debug` trait.
- The `{:?}` placeholder tells `println!` to use the `Debug` trait for formatting.

## Printing in Hexadecimal

Cairo allows integers to be printed in hexadecimal format using the `{:x}` placeholder.

```rust
let value: u32 = 255;
println!("{:x}", value); // Output: ff
```

This is especially useful when working with low-level data representations.
