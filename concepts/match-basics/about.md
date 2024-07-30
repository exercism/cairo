# Match Basics

The `match` expression allows for easy comparison of a value against a series of patterns and afterwards run the code based on which pattern matches. Literal values, variable names, wildcards, and many other things are what makes up a pattern.

The examples below show the `match` syntax:

```rust
match enum_var {
    variant_0(a, b, c) => {/* code */}
    variant_1(_) => {/* code */}
    ...
    variant_k(a, c) => {/* code */}
}

match felt_var {
    0 => { /* code */ }
    _ => { /* code */ }
}
```

The `variant_0`, `variant_1`, `...`, and `variant_k` are all variants of an enum data type. Where `enum_var` could be any instance of the enum, after matching, executes the code in the curly braces. While the second example is the usage of the match patterning with a `felt_var` felt252 with arm patterns of value `0` and wildcard, `_`.

Following the format above, we can write a function that takes in an unknown color parameter and return its true color.

```rust
enum Color {
    Red,
    Yellow,
    Green,
}

fn return_color_type(color: Color) -> felt252 {
    match color {
        Color:Red => println!("The color is Red"),`
        Color:Yellow => println!("The color is Yellow"),
        Color:Green => println!("The color is Green"),
    }
}
```

The `return_color_type` function prints the color of whichever unknown parameter was provided. Given the unknown `color` value, it would have several patterns that involves each of the variants to match. The arm of code to execute for each pattern is a one liner `println!("The color is ${color}")` of whatever the value match. To handle mutiple lines of code, the arm of code should be wrapped into a curly braces `{}`.

## Matching the `Option` enum type

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
    let four: Option<u8> = plus_one(three);
    let none = plus_one(Option::None);
}
```

## Matches cover all possible cases

One benefit of using the `match` control flow is due to its exhaustive nature. In Cairo, especially in the case of `Option<T>`, it expects that every possible pattern must be exhaustively handled else it will revert at compile time.

```rust
fn add_one(x: Option<u8>) -> Option<u8> {
    match x {
        Option::Some(val) => Option::Some(val + 1),
    }
}
```

This kind of bug is easier for the compiler to spot because in this case, the possibility that the `x` value could be a null value was not handled. The revert error looks like this error:

```sh
$ scarb cairo-run
   Compiling missing_match_arm v0.1.0 (home/Scarb.toml)
error: Missing match arm: `None` not covered.
 --> home/src/lib.cairo:5:5
    match x {
    ^*******^

error: could not compile `missing_match_arm` due to previous error
error: `scarb metadata` exited with error

```

The error shows that Cairo is aware of other uncovered possible cases that x could be. This error spells out the possibility of the `x` value being null and protect us from assuming that `x` will never be null.

## Catch-all pattern with `_` wildcard

Understanding how the `_` wildcard works is essential in order to effectively handle all cases. This is most times added as the last arm of a `match` expression. This is a special pattern whose arm of code is executed only after the critical patterns.

The allow_red function receives a parameter and return true if red and false for any other color instance.

```rust
fn allow_red(color: Color) -> bool {
    match color {
        Color::Red => true,
        _ => false,
    }
}
```

## Match patterning with the `or` (`|`) Operator

The Cairo `match` control flow construct allows for matching a value against multiple patterns handled by the `or` operator (`|`). With the use of the `or` operator in a match patterning, it helps achieve code simplicity.

For example, using the `Color` enum above, we want to write a function that returns true for `Red` or `Green` colors and false for other colors.

```rust
fn allow_red_and_green(color: Color) -> bool {
    match color {
        Color::Red | Color::Green => true,
        _ => false,
    }
}
```
