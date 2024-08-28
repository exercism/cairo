# Error Handling

Cairo provides error handling techniques to address issues, and manage errors, enabling running the code smoothly during execution.

There are two types of errors in Cairo:

- **Unrecoverable errors with `panic`** - these errors terminate the program immediately.
- **Recoverable Errors with `Result`** - these errors can be handled during runtime.

## Unrecoverable Errors with `panic`

In Cairo, unexpected issues may arise during program execution, resulting in runtime errors called "panics". This will stop the program execution, which is helpful in the case where continuing wouldn't make any sense. A panic can occur either inadvertently, through actions causing the code to panic (e.g., accessing an array beyond its bounds), or deliberately, by invoking the `panic` function.

```rust
fn main() {
    let data = array![1, 2];

    if true {
        panic(data);
    }
    println!("This line will not be reached.");
}
```

Running this example would print the following in the console:

```console
Run panicked with [1, 2, ].
```

There is also a special macro, called `panic!`, that allows a `ByteArray` to be used as the error message.

```rust
panic!("The error for the panic! Error message is not limited to 31 characters anymore");
```

### `nopanic` Notation

Cairo `nopanic` notation indicates that a function will never panic.

```rust
fn function_never_panic() -> felt252 nopanic {
    108
}
```

A `nopanic` function can only be called in a function also annotated as `nopanic`.

### `panic_with` Attribute

Cairo `panic_with` attribute to mark a function that returns an `Option` or `Result`, and will create a wrapper for your annotated function which will panic if the function returns `Option::None` or `Result::Err`.

```rust
#[panic_with('value is 0', wrap_not_zero)]
fn check_not_zero(value: u128) -> Option<u128> {
    if value == 0 {
        Option::None
    } else {
        Option::Some(value)
    }
}

fn main() {
    check_not_zero(0); // -> returns Option::None
    wrap_not_zero(0);  // -> panics with 'value is 0'
}
```

## Recoverable Errors with `Result`

The `Result` enum handles errors gracefully, providing feedback instead of crashing or producing undefined behavior.

```rust
enum Result<T, E> {
    Ok: T,
    Err: E,
}
```

Let's look at an example of how we could use this enum to handle a division by zero:

```rust
fn divide(a: u32, b: u32) -> Result<u32, ByteArray> {
    if b == 0 {
        return Result::Err("Error: Division by zero"); // Return an error if division by zero is attempted
    }
    Result::Ok(a / b)
}

fn main() {
    // Test with division by zero
    match divide(10, 0) {
        Result::Ok(result) => println!("Division successful: {}", result),
        Result::Err(e) => println!("{}", e),
    }
}
```

### The `?` Operator

The `?` operator is used for concise and implicit error handling, letting the calling function deal with any errors that might occur. When you use the `?` operator on a `Result` or `Option` type, it will do the following:

- If the value is `Result::Ok(x)` or `Option::Some(x)`, it will return the inner value `x` directly.
- If the value is `Result::Err(e)` or `Option::None`, it will propagate the error or `None` by immediately returning from the function.

```rust
fn parse_u8(s: felt252) -> Result<u8, felt252> {
    match s.try_into() {
        Option::Some(value) => Result::Ok(value),
        Option::None => Result::Err('Invalid integer'),
    }
}

fn do_something_with_parse_u8(input: felt252) -> Result<u8, felt252> {
    let input_to_u8: u8 = parse_u8(input)?;
    // DO SOMETHING
    let res = input_to_u8 - 1;
    Result::Ok(res)
}

fn main() {
    let number: felt252 = 258;
    match do_something_with_parse_u8(number) {
        Result::Ok(value) => println!("Result: {}", value),
        Result::Err(e) => println!("Error: {}", e),
    }
}
```
