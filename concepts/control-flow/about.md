# Control Flow

`If` expressions and `loops` control the flow of execution in Cairo by:

- Conditionally running code based on a `true` condition.
- Repeating code while a condition remains `true`.

These constructs are fundamental for implementing logic and iteration in Cairo.

## If Expressions

If expressions in Cairo allow you to control the flow of execution based on conditional logic. They follow a structure where code is executed depending on whether a condition evaluates to `true` or `false`.

## Basic If Expression:

```rust
if condition {
    // Code to execute if condition is true
}
```

A simple if block executed only if the condition evaluates to true. If the condition is false, no code is executed, and the program continues.

```rust
if condition {
    // Code to execute if condition is true
} else {
    // Code to execute if condition is false
}
```

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

This example uses an `if-else` expression to print a message based on whether `number` is less than `10`. The program evaluates the condition and executes the corresponding code block.

## Handling Multiple Conditions with `else if`

```rust
if condition1 {
    // Code to execute if condition1 is true
} else if condition2 {
    // Code to execute if condition1 is false and condition2 is true
} else {
    // Code to execute if neither condition1 nor condition2 is true
}
```

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

`if`, `else if`, and `else` evaluate multiple conditions and print the corresponding grade based on the `score`. Each condition is checked in order, and the first `true` condition determines the output.

## Using if in a let Statement

The if expression in Cairo can be used on the right side of a let statement to assign the result to a variable.

```rust
fn main() {
    let condition: bool = true;
    let number: felt = if condition {
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

Loops are fundamental construct that allow the repetition of code blocks, enabling efficient and controlled execution of tasks. Loops can iterate over a sequence or execute code repeatedly based on a condition. Cairo provides three primary loop flavors:

- **loop**: A basic loop that runs indefinitely unless explicitly stopped using a break statement.
- **while**: Continues to execute as long as a specified condition remains true. It stops when the condition becomes false.
- **for**: Iterates over elements in a collection, such as arrays, executing code for each element.

## Repeating Code with `loop`

```rust
fn main() {
    loop {
        println!("again!");
    }
}
```

Executes code indefinitely until stopped manually or via `break`.

To break out of a loop,place the `break` keyword within the loop to tell the program when to stop executing the loop.

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

## Returning Values from loops

You can return a value from a loop by using the break keyword followed by the value you want to return. This allows you to exit the loop and pass a result to the rest of your code.

```rust
fn main() {
    let mut counter: felt = 0;

    let result: felt = loop {
        if counter == 10 {
            break counter * 2;
        }
        counter += 1;
    };

    println!("The result is {}", result);
}
```

When `counter` equals 10, the loop breaks and returns `counter * 2`, storing the result in the variable `result`.

## Conditional Loops with `while`

`while` runs code while a condition is true, and exits when the condition becomes false.

```rust
fn main() {
    let mut number: felt = 3;
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
    let a: [felt; 5] = [10, 20, 30, 40, 50].span();
    for element: felt in a {
        println!("the value is: {}", element);
    }
}
```

## Concise Control Flow with `if let` and `while let`

`if let`

The `if let` syntax combines `if` and `let` to handle specific pattern matches more concisely.

Using `match` to handle an Option:

```rust
let config_max: Option<felt> = Option::Some(5);
match config_max {
    Option::Some(max: felt) => println!("The maximum is configured to be {}", max),
    _ => (),
}
```

Using `if let` for the same logic:

```rust
let number: Option<felt>  = Option::Some(5);
if let Option::Some(max: felt) = number {
    println!("The maximum is configured to be {}", max);
}
```

You can also include else with if let:

```rust
let coin: Coin = Coin::Quarter;
let mut count: felt = 0;
if let Coin::Quarter = coin {
    println!("You got a quarter!");
} else {
    count += 1;
}
```

`while let`:

The `while let` syntax loops over values, executing a block for each matching pattern.

```rust
fn main() {
    let mut arr: Array<felt> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut sum: felt = 0;
    while let Option::Some(value: felt) = arr.pop_front() {
        sum += value;
    }
    println!("{}", sum);
}
```
