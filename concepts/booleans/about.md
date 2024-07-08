# The Boolean Type

In Cairo, the Boolean type is essential for logical operations and conditional statements. Booleans in Cairo are represented as one `felt252` in size, ensuring efficient use of space while maintaining the simplicity of true/false logic.

The Boolean type in Cairo is specified using the keyword `bool`. This enables the declaration and manipulation of Boolean variables within the language. For instance, consider the following example:

```rust
fn main() {
    let t = true;

    let f: bool = false; // with explicit type annotation
}
```

In this example, two Boolean variables are declared. The variable $t$ is assigned the value true implicitly, while the variable $f$ is explicitly annotated with the bool type and assigned the value false.

One important aspect to note is that when declaring a bool variable in Cairo, it is mandatory to use either the true or false literals as the value. This means that integer literals, such as $0$ or $1$, cannot be used as substitutes for false or true. The strict enforcement of this rule ensures type safety and prevents potential logical errors in smart contract development.


The following code snippet demonstrates how to use Boolean types in Cairo. It shows the declaration of Boolean variables, assignment of Boolean expressions, and usage of assertions to verify the correctness of the Boolean logic.

```rust
fn main() {
    let t: bool = true;
    let true_expr = 5 == 5;
    assert(t == true_expr, 'this is true');

    let f: bool = false;
    let false_expr = 7 == 5;
    assert(f == false_expr, 'this is false');
}
```

## Declaration of Boolean Variables
```rust
let t: bool = true;
```
This line declares a Boolean variable t and assigns it the value true.

## Boolean Expression Evaluation
```rust
let true_expr = 5 == 5;
```
Here, a Boolean expression 5 == 5 is evaluated. Since the expression is true, true_expr is assigned the value true.

## Assertion for True Expression
```rust
assert(t == true_expr, 'this is true');
```
This assertion checks if the value of t is equal to true_expr. Since both are true, the assertion passes, and the message 'this is true' confirms the expected result.

## Declaration of Another Boolean Variable
```rust
let f: bool = false;
```
This line declares another Boolean variable f and assigns it the value false.

## Boolean Expression Evaluation for False
```rust
let false_expr = 7 == 5;
```
Here, another Boolean expression 7 == 5 is evaluated. Since the expression is false, false_expr is assigned the value false.

## Assertion for False Expression
```rust
assert(f == false_expr, 'this is false');
```
This assertion checks if the value of f is equal to false_expr. Since both are false, the assertion passes, and the message 'this is false' confirms the expected result.

## Summary
This code snippet illustrates the use of Boolean variables and expressions in Cairo. It highlights the following key points:

1. Declaring Boolean variables with explicit type annotations.
2. Evaluating Boolean expressions and assigning the results to variables.
3. Using assertions to verify that Boolean variables match the expected values of evaluated expressions.
