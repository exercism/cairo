# Functions

Functions are fundamental in Cairo.

By convention, Cairo uses **snake case** for function and variable names, where words are lowercase and separated by underscores.

Here's an example:

```rust
fn another_function() {
    println!("Another function.");
}

fn main() {
    println!("Hello, world!");
    another_function();
}
```

Functions are defined with `fn`, followed by a name, parentheses for parameters (if any), and a body enclosed in curly brackets.

You can call a function by its name followed by parentheses.

Function order doesn't matter as long as they're in scope.

## Parameters

Functions can take **parameters**, which are variables defined in the function signature.

When calling the function, you provide **arguments**, the values passed to these parameters.

```rust
fn main() {
    another_function(5);
}

fn another_function(x: felt252) {
    println!("The value of x is: {}", x);
}
```

Here, `x` is a parameter of type `felt252`.

When called with `5`, the function prints "The value of x is: 5".

Multiple parameters are separated by commas:

```rust
fn main() {
    print_labeled_measurement(5, "h");
}

fn print_labeled_measurement(value: u128, unit_label: ByteArray) {
    println!("The measurement is: {value}{unit_label}");
}
```

This prints: `The measurement is: 5h`.

## Statements and Expressions

Cairo functions are made up of **statements** and **expressions**:

- **Statements** perform actions but do not return values.
For example, `let x = 3;` is a statement.
- **Expressions** evaluate to a value.
For example, `5 + 6` evaluates to `11`.

Blocks enclosed in curly brackets are also expressions, and their final value is returned:

```rust
fn main() {
    let y = {
        let x = 3;
        x + 1
    };
    println!("The value of y is: {}", y);
}
```

Here, `y` is assigned the value `4`.

## Return Values

Functions can return values using the `->` syntax to specify the return type.

By default, a function returns the value of its final expression:

```rust
fn five() -> u32 {
    5
}

fn main() {
    let x = five();
    println!("The value of x is: {}", x);
}
```

This outputs: `The value of x is: 5`. 

For more complex cases:

```rust
fn plus_one(x: u32) -> u32 {
    x + 1
}

fn main() {
    let x = plus_one(5);
    println!("The value of x is: {}", x);
}
```

This prints: `The value of x is: 6`. 

Be mindful not to add a semicolon at the end of the final expression, as it would turn the expression into a statement, causing the function to return `()` (unit type) instead of the expected value.