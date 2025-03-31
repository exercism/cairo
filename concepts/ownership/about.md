# Ownership

In Cairo, the concept of ownership is attached to _variables_ rather than the _values_ they hold.

Values in Cairo are immutable, this immutability ensures that even if many variables refer to the same value, the value itself remains constant and unaltered.
So the compiler must ensure their correct usage by the programmer.
This is the meaning of variable _ownership_: the owner is the code that can read (and write if mutable) the variable.

## Variable Ownership Rules

```console
1. Each variable in Cairo has an owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the variable is destroyed.
```

## Variable Scope

A scope is the range within a program in which a variable is valid.
Let's look at the following example that declares a variable `x` of unsigned integer type, with comments annotating where the variable is valid:

```rust
fn main() {
                      // `x` is not valid here, it has not been declared yet
    let x: u32 = 3;   // `x` is declared, it is valid from this point forward
                      // do stuff with `x`

} // this scope ended here, `x` goes out of scope and is no longer valid
```

Notes:

- When `x` comes into scope, it is valid.
- It remains valid until it goes out of scope, in this case until the end of the `main()` function.

## Moving Values

A move occurs when a value is passed to another function, destroying the original variable that referred to the value (thus making the variable useless), and creating a new variable to hold the same value.

Arrays are an example of a complex type that is moved when passing it to another function.
Here is a short reminder of what an array looks like:

```rust
    let mut arr: Array<u128> = array![];
    arr.append(1);
    arr.append(2);
```

How does the type system ensure that the Cairo program never tries to write to the same memory cell twice?
Consider the following code, where we try to remove the front of the array twice:

```rust
fn foo(mut arr: Array<u128>) {
    arr.pop_front();
}

fn main() {
    let arr: Array<u128> = array![1];
    foo(arr);
    foo(arr); // -> compiler error: Variable was previously moved.
}
```

In this case, we try to pass the same value (the array in the `arr` variable) to both function calls.
This means our code tries to remove the first element twice, which would try to write to the same memory cell twice - which is forbidden by the Cairo VM, leading to a runtime error.
Thankfully, this code does not actually compile.
Once we have passed the array to the `foo` function, the variable `arr` is no longer usable.
We get this compile-time error, telling us that we would need `Array` to implement the `Copy` trait:

## The Copy Trait

If a type implements the `Copy` trait, passing it to a function doesn't move the value but creates a new variable referring to the same value.
This is a free operation because variables are a Cairo abstraction and values are always immutable.

To implement the `Copy` trait on your type, add the `#[derive(Copy)]` annotation to the type definition.
However, Cairo won't allow this if the type or any of its components doesn't implement the `Copy` trait.

```rust
#[derive(Copy, Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn main() {
    let p1 = Point { x: 5, y: 10 };
    foo(p1);
    foo(p1);
}

fn foo(p: Point) { // do something with p
}
```

## Destroying Values

Linear types can also be utilized by being destroyed, which ensures that the associated resource is correctly released.
This is accomplished by implementing or deriving the `Drop` trait, which signals to the compiler that the type can safely be destroyed once it's no longer useful.

```rust
#[derive(Drop)]
struct A {}

fn main() {
    A {}; // this value can be destroyed after going out of scope
}
```

At the moment, the `Drop` implementation can be derived for all types, except for dictionaries (`Felt252Dict`) and types containing dictionaries.
This is because dictionaries must be "squashed" when they are destroyed.
For this, we derive the `Destruct` trait:

```rust
#[derive(Destruct)]
struct A {
    dict: Felt252Dict<u128>
}

fn main() {
    A { dict: Default::default() };
}
```

## Return Values and Scope

Returning values is equivalent to moving them.
The example below shows an example of a function that returns some value:

```rust
#[derive(Drop)]
struct A {}

fn main() {
    let a1 = gives_ownership();           // gives_ownership moves its return
                                          // value into a1

    let a2 = A {};                        // a2 comes into scope

    let a3 = takes_and_gives_back(a2);    // a2 is moved into
                                          // takes_and_gives_back, which also
                                          // moves its return value into a3

} // Here, a3 goes out of scope and is dropped. a2 was moved, so nothing
  // happens. a1 goes out of scope and is dropped.

fn gives_ownership() -> A {               // gives_ownership will move its
                                          // return value into the function
                                          // that calls it

    let some_a = A {};                    // some_a comes into scope

    some_a                                // some_a is returned and
                                          // moves ownership to the calling
                                          // function
}

// This function takes an instance some_a of A and returns it
fn takes_and_gives_back(some_a: A) -> A { // some_a comes into scope

    some_a                                // some_a is returned and
                                          // moves ownership to the calling
                                          // function
}
```
