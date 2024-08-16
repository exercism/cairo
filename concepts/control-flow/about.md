# Control Flow

`If` expressions and loops control the flow of execution in Cairo by:
`

- **`If` expressions** conditionally run code based on whether a condition evaluates to true.
- **Loops** (such as `loop`, `while`, and `for`) repeatedly execute code while a specified condition remains true or until a breaking condition is met.

These constructs are fundamental for implementing logic and iteration in Cairo.

## `If` Expressions

`If` expressions in Cairo allow you to control the flow of execution based on conditional logic. They follow a structure where code is executed depending on whether a boolean condition evaluates to `true` or `false`.

```rust
fn main() {
    let temperature = 30;

    if temperature > 25 {
        println!("It's hot outside!");
    }
}
```

This example demonstrates a simple `if` block in Cairo. The message `"It's hot outside!"` is printed only if the condition `temperature > 25` evaluates to `true`. If the condition is `false`, no code is executed, and the program continues.

```rust
fn main() {
    let number: u32 = 5;

    if number < 10 {
        println!("The number is less than 10.");
    } else {
        println!("The number is 10 or greater.");
    }
}
```

Running this code will print `"The number is less than 10."` in the console.

### Handling Multiple Conditions with `else if`

You can use multiple conditions by combining `if` and `else` in an `else if` expression.

```rust
fn main() {
    let score: u64 = 85;

    if score >= 90 {
        println!("Grade: A");
    } else if score >= 80 {
        println!("Grade: B");
    } else if score >= 70 {
        println!("Grade: C");
    } else {
        println!("Grade: F");
    }
}
```

Running this code will print `"Grade: B"` in the console.

### Using `if` in a `let` Statement

The `if` expression in Cairo can be used on the right side of a `let` statement to assign the result to a variable.

```rust
fn main() {
    let condition: bool = true;
    let number: felt252 = if condition {
        5
    } else {
        6
    };

    if number == 5 {
        println!("condition was true and number is {}", number);
    }
}
```

## Loops

Loops are a fundamental construct that allow the repetition of code blocks, enabling efficient and controlled execution of tasks. Loops can iterate over a sequence or execute code repeatedly based on a condition. Cairo provides three primary loop flavors:

- **loop**: A basic loop that runs indefinitely unless explicitly stopped using a `break` statement.
- **while**: Continues to execute as long as a specified condition remains `true`. It stops when the condition becomes `false`.
- **for**: Iterates over elements in a collection, such as arrays, executing code for each element.

### Repeating Code with `loop`

The `loop` keyword tells Cairo to execute a block of code over and over again forever or until you explicitly tell it to stop.

```rust
fn main() {
    loop {
        println!("again!");
    }
}
```

Executing this code will print `"again!"` indefinitely in the console until either the program runs out of gas or we stop it manually.

> Note: Cairo prevents us from running program with infinite loops by including a gas meter. The gas meter is a mechanism that limits the amount of computation that can be done in a program. Gas is a unit of measurement that expresses the computation cost of an instruction. When the gas meter runs out, the program will stop.

To break out of a loop, place the `break` keyword within the loop to tell the program when to stop executing the it.

```rust
fn main() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        println!("i = {}", i);
        i += 1;
    }
}
```

The `continue` keyword tells the program to go to the next iteration of the loop and to skip the rest of the code in this iteration.

```rust
fn main() {
    let mut i: usize = 0;
    loop {
        if i > 10 {
            break;
        }
        if i == 5 {
            i += 1;
            continue;
        }
        println!("i = {}", i);
        i += 1;
    }
}
```

Executing this program will not print the value of `i` when it is equal to `5`.

#### Returning Values from loops

You can return a value from a `loop` by using the `break` keyword followed by the value you want to return. This allows you to exit the `loop` and pass a result to the rest of your code.

```rust
fn main() {
    let mut counter = 0;

    let result = loop {
        if counter == 10 {
            break counter * 2;
        }
        counter += 1;
    };

    println!("The result is {}", result); // prints "The result is 20"
}
```

### Conditional Loops with `while`

`while` runs code while a condition is `true`, and exits when the condition becomes `false`.

```rust
fn main() {
    let mut number = 3;
    while number != 0 {
        println!("{}!", number);
        number -= 1;
    }
    println!("LIFTOFF!!!");
}
```

### Looping Through a Collection with `for`

`for` Iterates over each item in a collection, executing code for each item.

```rust
fn main() {
    let a = [10, 20, 30, 40, 50].span();
    for element in a {
        println!("the value is: {}", element);
    }
}
```
