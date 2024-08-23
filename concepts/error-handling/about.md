# Error Handling

Cairo provides `Error Handling` techniques to address issues, and manage errors. It handles the enexpected behaviour to run the code smoothly while execution.
For example *devide by zero* situation.
> `Err("Cannot divide by zero")`

There are multiple ways to hendle errors in `Cairo`
- Recoverable Errors
    - Result enum: Handles potential errors in function.
    - Using `?`: Operator for error propagation.
- Unrecoverable errors
    - `panic`: Used to handle unrecoverable errors. It will stop the execution and print error.
    - `nopanic`: Used to avoid panic and handle error whithout stopping it.

## The Result Enum
This approach handles errors gracefully, providing feedback insted of crashing or producing undefined behaviiour.

**The code snippet below shows how enums could be defined:**
```
enum Result<T, E> {
    Ok: T,
    Err: E,
}
```

> Let's Take an example of `Devide By Zero` 
```
fn divide(a: felt, b: felt) -> Result<felt, &'static str> {
    if b == 0 {
        return Err("Error: Division by zero"); // Return an error if division by zero is attempted
    }
    Ok(a / b)
}
```

```
// Test with division by zero
match divide(10, 0) {
    Ok(result) => println!("Division successful: {}", result),
    Err(e) => println!("{}", e),
}
```
## The `?` Operator
`?` operator is used for minimilistic(concise) errors. Allow to write clean and readable code without explicit values.

>Example
```
fn safe_divide(a: felt, b: felt) -> Result<felt, &'static str> {
    // The ? operator automatically generate the error if it occurs
    let result = divide(a, b)?;
    Ok(result)
}
```

```
match safe_divide(10, 0) {
        Ok(value) => println!("Division successful: {}", value),
        Err(e) => println!("{}", e),
    }
```

## Error with `panic!` 
When program encounters an error which is unrecoverable then a `panic!` occures. This will stop execution and helpful for the case where continuing execution doesn't make any sense.

> Example
```
fn main() {
    if true {
        panic!("2");
    }
    println!("This line isn't reached");
}
```
> **Output** 
``` 
Run panicked with [1997209042069643135709344952807065910992472029923670688473712229447419591075, 0 (''), 50 ('2'), 1, ].
```

After the panic, the code execution will stop.

## `nopanic` Notation
Cairo nopanic Notation indicates that function will never panic. It makes code more user-friendly. 
> `nopanic` function can be called only in a function annotated as `nopanic`.

> Example
```
fn function_never_panic() -> felt252 nopanic {
    println!("No panic");
}
```

## `panic_with` Attribute
Cairo `panic_with` attribute simplifies error handling by allowing a function to automatically panic if it returns `None` or `Err`.

> Example
```
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

---
## Summary
Error handling involves identifying and addressing errors to execute a program smoothly. `Recoverable errors` doesn't stop the execution of program whereas `Unrecoverable Errors with panic` results runtime errors. Read more about `Error Handling` in [Cairo Book](https://book.cairo-lang.org/ch09-00-error-handling.html)
