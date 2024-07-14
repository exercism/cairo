# Enums

Enums are cairo data type used to define a set of predefined variants for the purpose of code readability and safety. In Cairo, `enum` variants can be declared to hold different data types (uint, struct, tuples, arrays, dictionaries, core default library, other enums).

The code snippet below shows how enums could be defined:

### Simple example of an enum with no associated value

```Rust
    #[derive(Drop)]
    enum Direction {
        North,
        East,
        South,
        West,
    }
```

The `Direction` enum declared above is a simple enum with four variants: `North`, `East`, `South`, and `West`. Notice that the variants are declared in PascalCase, being the recommended naming convention. Each variant represents a distinct value of the `Direction` enum type. Each variant in this particular enum example has no associated value and be instantiated using this syntax:

```Rust
    let direction = Direction::North;
```

### Simple example of an enum with associated value

```Rust
    #[derive(Drop)]
    enum Direction {
        North: u128,
        East: u128,
        South: u128,
        West: u128,
    }
```

It is evident from the second example that each variant in the `Direction` enum has an associated value of `u128`. This kind of enum is instantiated as follows:

```Rust
    let direction = Direction::North(10);
```

### Complex example of an enum with combined custom types

```Rust
    #[derive(Drop, Serde, Copy, starknet::Store)]
    struct Move {
        up: u32,
        down: u32,
        right: u32,
        left: u32,
    }

    #[derive(Drop, Serde, Copy, starknet::Store)]
    enum UserCommand {
        Login,
        UpdateProfile,
        Logout,
    }

    #[derive(Drop, Serde, Copy, starknet::Store)]
    enum Action {
        Quit,
        Direction: Move,
        SendMessage: felt252,
        ChangeAvatarColor: (u8, u8, u8),
        ProfileState: UserCommand
    }
```

An enum can be declared with a combination of custom data types as its variants. In the example above, the `Action` is the complex enum that as a collection of `Quit` (variant with no associated value), `Direction` (variant with the `Move` struct associated value), `SendMessage` (a single felt252 variant), `ChangeAvatar` (variant with the tuple of three associated value), and `ProfileState` (variant with an enum associated value).

You can declare an enum inside and outside of a contract. If declared outside, then it should be imported inside a contract with the `use` keyword.

## Trait Implementations for Enums

In Cairo, traits could be defined and implemented on custom enums. This allows for you to define methods and attributes associated with the enum. We will implement a `Processing` trait on a `Message` enum.

```Rust
    #[derive(Drop)]
    enum Message {
        Quit,
        Echo: felt252,
        Move: (u128, u128),
    }
```

The `Message` enum is made up of:

~ `Quit` has no associated value.

~ `Echo` is a single felt252 value.

~ `Move` is a tuple of two u128 values.

```Rust
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

In many situations, enums can come in handy especially when used with the `match` flow as used above in the traits implementation.

Here is how it could be used to process a Quit message:

```Rust
    let msg: Message = Message::Quit;
    msg.process();
```

Running this code would print `quitting`.

## The `Option` Enum and its Advantages

The `Option` enum is a standard Cairo enum that represents the concept of an optional value. It has two variants: `Some: T` and `None`. `Some` variant has an associated value of type `T`, while `None` represents the absence of an associated value.

```Rust
enum Option<T> {
    Some: T,
    None,
}
```

The Option enum is helpful because it allows you to explicitly represent the possibility of a value being absent, making your code more expressive and easier to reason about. Using Option can also help prevent bugs caused by using uninitialized or unexpected null values.

Other native enums such as `Result` enum, allows for thorough error handling. The Result enum is will explained in details in the `Error Handling` chapter.
