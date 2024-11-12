# Introduction

In programming, it's essential to handle errors gracefully to ensure that unexpected situations do not cause a program to crash or behave unpredictably. Cairo provides two main mechanisms for error handling:

1. **Unrecoverable errors** with `panic`, which immediately stop the program.
2. **Recoverable errors** with `Result`, which allow the program to handle and respond to errors.

## Unrecoverable Errors with `panic`

Sometimes, a program encounters an error so severe that it cannot proceed. Cairo uses the `panic` function to immediately stop execution in such cases. This is helpful when an error, like attempting to access an out-of-bounds index, makes it impossible for the program to continue in a sensible way. The `panic` function accepts a `ByteArray` message that describes the reason for the error.

For example, in Cairo:

```rust
fn main() {
    let data = array![1, 2];
    panic("An unrecoverable error has occurred!");
}
```

This example demonstrates a forced panic, which immediately stops the program with a message.

### The `assert!` Macro

The `assert!` macro is a useful tool for enforcing specific conditions in your code. If the condition in `assert!` evaluates to `false`, the program will panic with a `ByteArray` error message. This is often used to verify assumptions during development and ensure values meet certain criteria.

For example:

```rust
fn main() {
    let x = 5;
    assert!(x > 0, "x must be greater than zero");
}
```

If `x` is not greater than zero, the program will panic with the message `"x must be greater than zero"`. `assert!` is helpful for checking invariants and preconditions without manually writing error-handling code.

## Recoverable Errors with `Result`

Not all errors need to stop the program. Some can be handled gracefully so the program can continue. Cairo's `Result` enum represents these recoverable errors, and it has two variants:

- `Result::Ok` indicates success.
- `Result::Err` represents an error.

Using `Result`, a function can return either a success value or an error, allowing the calling function to decide what to do next.

```rust
fn divide(a: u32, b: u32) -> Result<u32, ByteArray> {
    if b == 0 {
        Result::Err("Error: Division by zero")
    } else {
        Result::Ok(a / b)
    }
}
```

In this example, if `b` is zero, an error is returned; otherwise, the result of the division is returned.

## Error Handling with the `?` Operator

Cairo also provides the `?` operator, which simplifies error handling by automatically returning an error from the function if one occurs, or by passing the successful value onward. The `?` operator can be used with both `Result` and `Option` types to propagate errors or `None` values, making the code more concise.

```rust
fn parse_u8(s: felt252) -> Result<u8, felt252> {
    match s.try_into() {
        Option::Some(value) => Result::Ok(value),
        Option::None => Result::Err("Invalid integer"),
    }
}

fn main() {
    let result = parse_u8(258)?;
}
```

This introduction to error handling will be essential as you implement basic calculator functionality with error management in Cairo, utilizing both `panic` for critical issues and `Result` for gracefully handling less severe errors.
````