# Error Handling

Cairo provides `error handling` techniques to address issues, and manage errors, enabling running the code smoothly during execution.

There are multiple ways to handle errors in `Cairo`.
- Recoverable Errors
    - `Result` enum: Handles potential errors in function.
    - Using `?`: Operator for error propagation.
- Unrecoverable errors
    - `panic`: Used to handle unrecoverable errors. It will stop the execution and print error.
    - `nopanic`: Used to avoid panic and handle error whithout stopping it.

## The Result Enum
This approach handles errors gracefully, providing feedback insted of crashing or producing undefined behaviour.

```
enum Result<T, E> {
    Ok: T,
    Err: E,
}
```

Let's look at an example of `Divide By Zero`:
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
## The `?` Operator
`?` operator is used for concise and implicit error handling, letting the calling function deal with any errors that might occur.

Example
```rust
fn safe_divide(a: u32, b: u32) -> Result<felt252, ByteArray> {
    // The ? operator automatically generate the error if it occurs
    let result = divide(a, b)?;
    Result::Ok(result)
}

fn main() {
    match safe_divide(10, 0) {
        Ok(value) => println!("Division successful: {}", value),
        Err(e) => println!("{}", e),
    }
}
```

## Error with `panic` 
When program encounters an error which is unrecoverable then a `panic` occurs. This will stop the execution, which is helpful in the case where continuing the execution wouldn't make any sense.

Example
```rust
fn main() {
    let data = array![1, 2];

    if true {
        panic(data);
    }
    println!("This line will not be reached.");
}
```
Running this example would print this in the console:

```console
Run panicked with [1, 2, ].
```

There is also a special macro called `panic!`, that allows you to use a `ByteArray` as the error message.
```rust
panic!("The error for the panic! Error message is not limited to 31 characters anymore");
```

## `nopanic` Notation
Cairo `nopanic` notation indicates that a function will never panic. It makes code more user-friendly. 
> `nopanic` function can be called only in a function annotated as `nopanic`.

Example
```rust
fn function_never_panic() -> felt252 nopanic {
    108
}
```

## `panic_with` Attribute
Cairo `panic_with` attribute simplifies error handling by allowing a function to automatically panic if it returns `None` or `Err`.

Example
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
    check_not_zero(0); // -> returns None
    wrap_not_zero(0);  // -> panics with 'value is 0'
}
```
