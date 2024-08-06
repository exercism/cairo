# Match Basics

The `match` expression allows for easy comparison of a value against a series of patterns and afterwards running the code based on the matched pattern. Literal values, variable names, wildcards, and many other things are what makes up a pattern.

```rust
#[derive(Drop)]
enum Color {
    Red,
    Yellow,
    Green,
}

fn print_color_type(color: Color) {
    match color {
        Color::Red => println!("The color is Red"),
        Color::Yellow => println!("The color is Yellow"),
        Color::Green => println!("The color is Green"),
    }
}

fn main() {
    let color = Color::Yellow;
    specified_color(color);
}
```

To handle multiple lines of code, the `match` arm of code should be wrapped in curly braces `{}`:

```rust
fn specified_color(color: Color) -> felt252 {
    let mut response: felt252 = '';

    match color {
        Color::Red => {
            response = 'You passed in Red';
        },
        Color::Yellow => {
            response = 'You passed in Yellow';
        },
        Color::Green => {
            response = 'You passed in Green';
        },
    }

    response
}
```

The `match` expression also possesses the feature of binding to values that match the pattern. This makes it possible to extract the associated value of an enum variant.

```rust
#[derive(Drop, Debug)]
enum ColorType {
    Light,
    Dark,
}

#[derive(Drop)]
enum Color {
    Red: ColorType,
    Yellow,
    Green,
}

fn print_color_type(color: Color) {
    match color {
        Color::Red(state) => {
            println!("The color is Red");
            println!("The Color Type is {:?}", state);
        },
        Color::Yellow => println!("The color is Yellow"),
        Color::Green => println!("The color is Green"),
    }
}

fn main() {
    let color = Color::Red(ColorType::Dark);
    print_color_type(color);
}
```

Extending the `Red` variant of the `Color` enum to have an associated enum. With the help of the `match` expression, we could extract the associated value; `state`. This is simply a variable name which could be used afterwards in the code arm.

## Matching the `Option` Enum Type

The built-in `Option` enum can as well be handled with the `match` patterning to help get the inner `T` value out of the `Some` variant and other cases. There are no difference in how the match patterning are formed for the `Option` enum, only that the variants make up the arms.

Let's design a function that takes in an `Option<u8>` parameter. If there is a value from the provided parameter, add one to this value else the function should return the `None` value with no operation.

```rust
fn add_one(x: Option<u8>) -> Option<u8> {
    match x {
        Option::Some(val) => Option::Some(val + 1),
        Option::None => Option::None,
    }
}

fn main() {
    let three: Option<u8> = Option::Some(3);
    let four: Option<u8> = add_one(three);
    let none = add_one(Option::None);

    println!("{three:?}"); // prints "Option::Some(3)"
    println!("{four:?}"); // prints "Option::Some(4)"
    println!("{none:?}"); // prints "Option::None(())"
}
```

> Note: `{:?}` is a special formatting syntax that allows to print a debug form of the parameter passed to the `println!` macro. You can find more information about it in [The Cairo Book](https://book.cairo-lang.org/appendix-03-derivable-traits.html#debug-for-printing-and-debugging).

One benefit of using the `match` control flow is its exhaustive nature: the arms’ patterns must cover _all_ possibilities. Consider the version of the previous example that does not handle the `None` case:

```rust
fn add_one(x: Option<u8>) -> Option<u8> {
    match x {
        Option::Some(val) => Option::Some(val + 1),
    }
     // this code does not compile, as we forgot to handle the `None` case
}
```

## Catch-all Pattern with `_` Wildcard

Using enums, we can also take special actions for a few particular values, but for all other values perform one default action by adding a new arm with `_` as the pattern for the last arm of the match expression. The `_` pattern is a special pattern that matches any value and does not bind to that value.

The `is_red` function receives a parameter and return `true` if the color is `Red` and `false` for any other color:

```rust
fn is_red(color: Color) -> bool {
    match color {
        Color::Red => true,
        _ => false,
    }
}
```

## Pattern Matching with the `|` Operator

The Cairo `match` control flow construct allows for matching a value against multiple patterns using the `|` (_or_) operator. This helps simplify the code.

For example, using the `Color` enum, we want to write a function that returns `true` for `Red` or `Green` colors and `false` for other colors:

```rust
fn is_red_or_green(color: Color) -> bool {
    match color {
        Color::Red | Color::Green => true,
        _ => false,
    }
}
```

## Pattern Matching with `felt252` and Integer Variables

It is possible to match `felt252` and integer variables against a set of values. However, there are some constraints;

- Only support integers that fit into a single `felt252` (i.e `u256` is not supported).
- 0 must be the first arm.
- Each arm must follow a sequential segment, contiguously with other arms.

Let's implement a six-sided die tossing game. When this die is tossed, we get a number between 0 and 5. For a toss that yields 0, 1 or 2, you win. You roll again if you have 3. You loss for other values:

```rust
fn toss(value: u8) {
    match value {
        0 | 1 | 2 => println!("you won!"),
        3 => println!("you can roll again!"),
        _ => println!("you lost...")
    }
}

fn main() {
    toss(2); // prints "you won!".
    toss(3); // prints "you can roll again!".
    toss(5); // prints "you lost...".
}
```

## Matching Tuples

Tuples can also be matched against a set of patterns. These patterns are designed similarly as a tuple.

```rust
#[derive(Drop)]
enum DayType {
    Week,
    Weekend,
    Holiday
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn vending_machine_accept(c: (DayType, Coin)) -> bool {
    match c {
        (DayType::Week, _) => true, // accepts all coins during week day
        (_, Coin::Dime) | (_, Coin::Quarter) => true, // accepts only Dime or Quarter coin for all specified days
        (_, _) => false, // returns false for other instances
    }
}
```

In the last match arm, it doesn't matter if we use `(_, _)` or just `_` wildcard to match any day and color combination, because they're functionally the same.
