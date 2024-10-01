# Introduction

A function in Cairo allows you to group code into a reusable unit, making your programs more modular and easier to understand. Functions in Cairo consist of the `fn` keyword, followed by the function name, a list of parameters in parentheses, and a code block that defines what the function does.

## Function Parameters

In Cairo, all function parameters must be explicitly typed. Unlike some languages, Cairo does not infer types, and there are no default parameter values, so all parameters are required.

```rust
// Function with no parameters
fn print_hello() {
    // Function body
}

// Function with two parameters
fn print_greeting_name(greeting: ByteArray, name: ByteArray) {
    // Function body
}
```

## Parameters vs. Arguments

It's important to distinguish between `parameters` and `arguments`:

- **Parameters** are the variable names used in the function definition, such as `greeting` and `name` in the function `print_greeting_name`.
- **Arguments** are the actual values passed to the function when it is called.

```rust
// Calling the function with arguments
print_greeting_name(123, 456)
```

## Statements and Expressions

Function bodies are made up of a series of statements optionally ending in an expression.

- Statements are instructions that perform some action and do not return a value.
- Expressions evaluate to a resultant value.

Creating a variable and assigning a value to it with the `let` keyword is a statement.

```rust
let y = 6;
```

But the `6` in the above statement is an expression that evaluates to the value `6`.

Calling a function is an expression since it always evaluates to a value: the function's explicit return value, if specified, or the 'unit' type `()` otherwise.

## Return Values

Cairo functions can return values to the code that calls them. Return values are listed after the parameters, separated by an arrow `->`. In Cairo, the return value of the function is synonymous with the value of the final expression in the block of the body of a function. You can return early from a function by using the `return` keyword and specifying a value.

```rust
// Function returning the last (and only) expression
fn hello(name: ByteArray) -> ByteArray {
    "Hello " + name
}

// Function returning using the `return` keyword
fn double_if_even(value: u32) -> u32 {
    if value % 2 == 0 {
        return value * 2;
    }
    return value;
}
```

## Invoking Functions

To call a function in Cairo, you simply use the function name followed by arguments in parentheses.

```rust
// Calling a function with no parameters
print_hello()

// Calling a function with one parameter
let greeting = hello("John")

// Calling a function with multiple parameters
print_greeting_name("Howdy", "Joel")
```
