# Options

The `Option` enum is a standard Cairo enum that represents the concept of an optional value.
It has two variants: `Some: T` and `None`.
`Some` variant has an associated value of type `T`, while `None` represents the absence of an associated value.

```rust
enum Option<T> {
    Some: T,
    None,
}
```

The `Option` enum is helpful because it allows you to explicitly represent the possibility of a value being absent, making your code more expressive and easier to reason about.
Using `Option` can also help prevent bugs caused by using uninitialized or unexpected `null` values.

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

The `if let` syntax combines `if` and `let` to handle specific pattern matches more concisely.

Using `match` to handle an `Option`:

```rust
let config_max: Option<felt252> = Option::Some(5);
match config_max {
    Option::Some(max) => println!("The maximum is configured to be {}", max),
    _ => (),
}
```

Using `if let` for the same logic:

```rust
let number: Option<felt252>  = Option::Some(5);
if let Option::Some(max) = number {
    println!("The maximum is configured to be {}", max);
}
```

You can also include an `else` with `if let`:

```rust
let coin: Coin = Coin::Quarter;
if let Coin::Quarter = coin {
    println!("You got a quarter!");
} else {
    println!("You got some other coin!");
}
```

The `while let` syntax loops over `Option` values, executing a block for each matching pattern.

```rust
fn main() {
    let mut arr: Array<felt252> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut sum: felt252 = 0;
    while let Option::Some(value) = arr.pop_front() {
        sum += value;
    }
    println!("{}", sum);
}
```

There are other native enums, one of which is the `Result` enum, which allows for graceful error handling.
Read more about the `Result` enum in [The Cairo Book][results].

[results]: https://book.cairo-lang.org/ch09-02-recoverable-errors.html#the-result-enum
