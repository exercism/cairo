# Introduction

Control flow in Cairo allows you to control the execution path of your programs based on conditions and repetition.

## Conditional Execution

Use `if` expressions to execute code based on conditions:

```rust
let number = 42;
if number > 0 {
    println!("Positive number");
} else if number < 0 {
    println!("Negative number");  
} else {
    println!("Zero");
}
```

`if` is an expression, so it can return values:

```rust
let result = if condition { 5 } else { 10 };
```

## Loops

Use `loop` to repeat code until a condition is met:

```rust
let mut counter = 0;
loop {
    if counter == 5 {
        break;
    }
    println!("Counter: {}", counter);
    counter += 1;
}
```

Loops can return values using `break`:

```rust
let result = loop {
    counter += 1;
    if counter == 10 {
        break counter * 2; // Returns 20
    }
};
```

Use `continue` to skip to the next iteration:

```rust
let mut i = 0;
loop {
    i += 1;
    if i % 2 == 0 {
        continue; // Skip even numbers
    }
    if i > 10 {
        break;
    }
    println!("{}", i); // Only prints odd numbers
}
```
