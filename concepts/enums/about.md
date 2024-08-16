# Enums

Enums are Cairo data type used to define a set of predefined variants for the purpose of code readability and safety. In Cairo, `enum` variants can be declared to hold different data types (integers, structs, tuples, other enums, etc.).

The code snippet below shows how enums could be defined:

```rust
#[derive(Drop)]
enum Direction {
    North,
    East,
    South,
    West,
}
```

The `Direction` enum declared above is a simple enum with four variants: `North`, `East`, `South`, and `West`. The naming convention is to use PascalCase for enum variants. Each variant represents a distinct value of the `Direction` enum type. Each variant in this particular enum example has no associated value and can be instantiated using this syntax:

```rust
let direction = Direction::North;
```

Below is the same `Direction` enum, but with variants that have associated values, that store the exact degree of the direction:

```rust
#[derive(Drop)]
enum Direction {
    North: u128,
    East: u128,
    South: u128,
    West: u128,
}
```

It is evident from this example that each variant in the `Direction` enum has an associated value of `u128`. This kind of enum can be instantiated as follows:

```rust
let direction = Direction::North(10);
```

## Complex Enum Example with Custom Types

An enum can be declared with a combination of different data types as its variants. In the example below, `Action` is a complex enum that as a collection of `Quit`, `Direction`, `SendMessage`, `ChangeAvatar`, and `ProfileState` as variants.

```rust
#[derive(Drop)]
struct Move {
    up: u32,
    down: u32,
    right: u32,
    left: u32,
}

#[derive(Drop)]
enum UserCommand {
    Login,
    UpdateProfile,
    Logout,
}

#[derive(Drop)]
enum Action {
    Quit, //  variant with no associated value
    Direction: Move, // variant with the `Move` struct associated value
    SendMessage: felt252, // a single felt252 variant
    ChangeAvatarColor: (u8, u8, u8), // variant with the tuple of three associated values
    ProfileState: UserCommand // variant with an enum associated value
}
```

## Trait Implementations for Enums

In Cairo, traits can be defined and implemented on custom enums. This allows for you to define methods and attributes associated with an enum. Below is an example of this where we define a `Message` enum and implement a `Processing` trait for it:

```rust
#[derive(Drop)]
enum Message {
    Quit,
    Echo: felt252,
    Move: (u128, u128),
}

trait Processing {
    fn process(self: Message);
}

impl ProcessingImpl of Processing {
    fn process(self: Message) {
        match self {
            Message::Quit => { println!("quitting") },
            Message::Echo(value) => { println!("echoing {}", value) },
            Message::Move((x, y)) => { println!("moving from {} to {}", x, y) },
        }
    }
}
```

Here is how the trait could be used to process a `Quit` message:

```rust
let msg: Message = Message::Quit;
msg.process(); // prints "quitting"
```

In many situations, enums can come in handy especially when used with the `match` flow as used above in the traits implementation. Read more about the `match` flow in [The Cairo Book](https://book.cairo-lang.org/ch06-02-the-match-control-flow-construct.html).

## The `Option` Enum and Its Advantages

The `Option` enum is a standard Cairo enum that represents the concept of an optional value. It has two variants: `Some: T` and `None`. `Some` variant has an associated value of type `T`, while `None` represents the absence of an associated value.

```rust
enum Option<T> {
    Some: T,
    None,
}
```

The `Option` enum is helpful because it allows you to explicitly represent the possibility of a value being absent, making your code more expressive and easier to reason about. Using `Option` can also help prevent bugs caused by using uninitialized or unexpected `null` values.

The function below shows how the `Option` enum is used to return the index of the first element of an array with a given value, or return `None` if the element is absent.

```rust
fn find_value(mut arr: Span<felt252>, value: felt252) -> Option<usize> {
    let mut result = Option::None;
    let mut index = 0;

    while let Option::Some(array_value) = arr
        .pop_front() {
            if (*array_value == value) {
                result = Option::Some(index);
                break;
            };

            index += 1;
        };

    result
}
```

## Concise Control Flow with `if let` and `while let`

`if let`

The `if let` syntax combines `if` and `let` to handle specific pattern matches more concisely.

Using `match` to handle an Option:

```rust
let config_max: Option<felt> = Option::Some(5);
match config_max {
    Option::Some(max: felt) => println!("The maximum is configured to be {}", max),
    _ => (),
}
```

Using `if let` for the same logic:

```rust
let number: Option<felt>  = Option::Some(5);
if let Option::Some(max: felt) = number {
    println!("The maximum is configured to be {}", max);
}
```

You can also include else with if let:

```rust
let coin: Coin = Coin::Quarter;
let mut count: felt = 0;
if let Coin::Quarter = coin {
    println!("You got a quarter!");
} else {
    count += 1;
}
```

`while let`:

The `while let` syntax loops over values, executing a block for each matching pattern.

```rust
fn main() {
    let mut arr: Array<felt> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut sum: felt = 0;
    while let Option::Some(value: felt) = arr.pop_front() {
        sum += value;
    }
    println!("{}", sum);
}
```

There are other native enums, one of which is the `Result` enum, which allows for graceful error handling. Read more about the `Result` enum in [The Cairo Book](https://book.cairo-lang.org/ch09-02-recoverable-errors.html#the-result-enum).
