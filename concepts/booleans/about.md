# The Boolean Type

In Cairo, the Boolean type is essential for logical operations and conditional statements. Booleans in Cairo are one `felt252` in size, ensuring efficient use of space while maintaining the simplicity of true/false logic.

The Boolean type in Cairo is specified using the keyword `bool`. This enables the declaration and manipulation of Boolean variables within the language. For instance, consider the following example:

```rust
fn main() {
    let t = true;
    let f: bool = false; // with explicit type annotation
}
```

In this example, two Boolean variables are declared. The variable `t` is assigned the value `true` and declared as a boolean type implicitly, while the variable `f` is explicitly annotated with the `bool` type and assigned the value `false`.

One important aspect to note is that when declaring a boolean variable in Cairo, it is mandatory to use either the `true` or `false` literals as the value. This means that integer literals, such as `0` or `1`, cannot be used as substitutes for `false` or `true`. The strict enforcement of this rule ensures type safety and prevents potential logical errors in smart contract development.

## Boolean Operators in Cairo

- `||` (logical OR): Returns `true` if at least one of the operands is `true`.
- `&&` (logical AND): Returns `true` if both operands are `true`.
- `!` (logical NOT): Returns the opposite Boolean value of the operand.

## Example Code

The following code snippet demonstrates how to use boolean types in Cairo. It shows the declaration of boolean variables, assignment of boolean expressions, and usage of assertions to verify the correctness of the boolean logic.

```rust
fn main() {
    // Declaration of Boolean variables
    let t: bool = true;
    let f: bool = false;

    // Boolean expression evaluation
    let true_expr = 5 == 5; // true
    let false_expr = 7 == 5; // false

    // Using Boolean operators
    let or_expr = t || f; // true || false => true
    let and_expr = t && f; // true && false => false
    let not_expr = !f; // !false => true

    // Assertions to verify the correctness
    assert(t == true_expr, 'this should be true'); // t == true
    assert(f == false_expr, 'this should be false'); // f == false
    assert(or_expr == true, 'this should be true for OR'); // true
    assert(and_expr == false, 'this should be false for AND'); // false
    assert(not_expr == true, 'this should be true for NOT'); // true
}
```

