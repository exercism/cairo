# Introduction

Printing in Cairo allows you to display messages or debug information during program execution.

## Basics

Cairo provides two macros for printing:

- `println!`: Outputs a message followed by a newline.
- `print!`: Outputs a message without a newline.

```rust
println!("Hello, Cairo!"); 
println!("x = {}, y = {}", 10, 20); 
```

Placeholders `{}` are replaced with provided values.

## Formatting Strings

Use `format!` to create a `ByteArray` without immediately printing:

```rust
let result = format!("{}-{}-{}", "tic", "tac", "toe");
println!("{}", result); // Output: tic-tac-toe
```

## Custom Data Types

For custom types, implement `Display` or derive `Debug` for printing:

```rust
#[derive(Debug)]
struct Point { x: u8, y: u8 }

let p = Point { x: 3, y: 4 };
println!("{:?}", p); // Debug output: Point { x: 3, y: 4 }
```

## Hexadecimal Printing

Use `{:x}` to print integers as hexadecimal:

```rust
println!("{:x}", 255); // Output: ff
```
