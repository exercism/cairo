# Introduction

Enums in Cairo allow you to define a type that can be one of several named variants.

## Basics

Enums, short for enumerations, limit all possible values of some data to a predefined set.
The possible values of an `enum` are called variants:

```rust
#[derive(Drop)]
enum Direction {
    North,
    South,
    East,
    West,
}
```

Create enum values by specifying the variant:

```rust
let my_direction = Direction::North;
let another_direction = Direction::West;
```

## Pattern Matching

Use match to handle different enum variants:

```rust
match my_direction {
    Direction::North => println!("Going north!"),
    Direction::South => println!("Going south!"),
    Direction::East => println!("Going east!"),
    Direction::West => println!("Going west!"),
}
```

Each arm of the match handles one variant of the enum.

## Enums with Data

Enum variants can hold additional data:

```rust
struct Location {
    x: u32,
    y: u32,
}

enum Message {
    Text: ByteArray,
    Number: u32,
    Location: Location,
}
```

Pattern match to extract the data:

```rust
match msg {
    Message::Text(content) => println!("Text: {}", content),
    Message::Number(val) => println!("Number: {}", val),
    Message::Location(Location { x, y }) => println!("Position: ({}, {})", x, y),
}
```
