# Introduction

## Structs

Structs are custom data types that let you name and package together multiple related values.

To define a struct, use the `struct` keyword followed by a name and curly braces containing the fields with their names and types:

```rust
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}
```

To create an instance of a `struct`, specify the `struct` name and use curly braces with key-value pairs for the fields.

```rust
let user = User {
   active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};
```

Use dot notation to access or modify the fields of a mutable `struct` instance.

```rust
let mut user = User {
    active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};
user.email = "anotheremail@example.com";
```

## Ownership

Values in Cairo are immutable, and this immutability ensures that even if many variables refer to the same value, the value itself remains constant and unaltered.
The _owner_ of a variable is the code that can read (and write if mutable) that variable.

Rules of ownership in Cairo:

1. Each variable in Cairo has an owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the variable is destroyed.

A scope is the range within a program in which a variable is valid.

```rust
fn main() {
                      // `x` is not valid here, it has not been declared yet
    let x: u32 = 3;   // `x` is declared, it is valid from this point forward
                      // do stuff with `x`

} // this scope ended here, `x` goes out of scope and is no longer valid
```

When a variable goes out of scope it is destroyed, which ensures that the associated resource is correctly released.
This is accomplished by implementing or deriving the `Drop` trait, which signals to the compiler that the type can safely be destroyed once it's no longer useful.

```rust
#[derive(Drop)]
struct A {}

fn main() {
    A {}; // this value can be destroyed after going out of scope
}
```

At the moment, the `Drop` implementation can be derived for all types, except for dictionaries (`Felt252Dict`) and types containing dictionaries.

A value can also be _moved_, which occurs when a value is passed to another function, destroying the original variable that referred to the value (thus making the variable useless), and creating a new variable to hold the same value.

```rust
fn foo(num: u32) { 
    // do something with p
}

fn main() {
    let num: u32 = 10;
    foo(num);
    // ownership of `num` was moved into `foo` and is thus no longer valid in this scope
}
```

Returning values is equivalent to moving them.

The example below shows an example of a function that returns some value:

```rust
#[derive(Drop)]
struct A {}

fn main() {
    // main now owns a1
    let a1 = gives_ownership();

    // a2 comes into scope
    let a2 = A {};

    // a2 is moved into takes_and_gives_back, which also moves its return value into a3
    let a3 = takes_and_gives_back(a2);
} // Here, a3 and a1 go out of scope and are dropped. a2 was moved, so nothing happens.

// Moves its return value into the function that calls it
fn gives_ownership() -> A {
    let some_a = A {};
    some_a
}

// This function takes an instance some_a of A and returns it
fn takes_and_gives_back(some_a: A) -> A {
    some_a
}
```

Because a variable is destroyed after being moved, the compiler forbids us from reusing it afterwards.

```rust
#[derive(Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn foo(p: Point) { 
    // do something with p
}

fn main() {
    let p = Point { x: 5, y: 10 };
    foo(p);
    foo(p); // compiler error: Variable was previously moved.
}
```

In this case, we try to pass the same value (the `Point` struct in the `p` variable) to both function calls.
Once we have passed the variable to the `foo` function the first time, the variable is no longer usable.

One way to address it to derive the `Copy` trait on our struct, which would alter what happens when we pass a `Copy` variable to a function - it would no longer move the value, but create a new variable referring to the same value.
This is a free operation because variables are a Cairo abstraction and values are always immutable.

To implement the `Copy` trait on your type, add the `#[derive(Copy)]` annotation to the type definition.

```rust
#[derive(Copy, Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn foo(p: Point) { 
    // do something with p
}

fn main() {
    let p = Point { x: 5, y: 10 };
    foo(p);
    foo(p); // this now works
}
```

## References and Snapshots

Cairo has two features for passing a value without destroying or moving it, called `references` and `snapshots`.

Snapshots provide an immutable "view" of a value at a certain point in time, allowing you to retain ownership of a variable while accessing its state.
Any modification to the variable creates a new memory cell, leaving the snapshot's view unchanged.

To create a snapshot, simply prefix the variable instance with `@`.

```rust
// this function takes in a snapshot using `@` with the data-type
fn get_len(arr: @Array<u128>) -> u32 { // 
    arr.len()
}

fn foo(arr: Array<u128>) {
    arr.pop_front();
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8];
    let snapshot = @new_arr; // using `@` to create a snapshot of a variable
    let len = get_len(snapshot); // pass the snapshot as argument, retaining ownership
    foo(new_arr); // `new_arr` is still valid up until here and no further
}
```

To convert a snapshot back into a regular variable, you can use the desnap operator `*`, which serves as the opposite of the `@` operator.
Only those types that implement the `Copy` trait can be desnapped.

```rust
fn square(n: @u32) -> u32 {
    let n = *n; // we desnap the value
    n * n
}

fn main() {
    let num: u32 = 10;
    let squared = square(@num); // we use `@` to create a snapshot
    println!("{} squared = {}", num, squared);
}
```

References allow you to pass mutable values to functions and have them implicitly returned, maintaining ownership in the calling context.
This can be achieved using the `ref` modifier, provided the variable is declared as mutable with the `mut` keyword.

We can update the previous `Point` example to use mutable references instead of relying on the `Copy` trait and it would still work.

```rust
#[derive(Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn foo(ref p: Point) { 
    // we can now update the passed values and the changes
    // will be visible in the calling context
    p.x += 1;
}

fn main() {
    let mut p = Point { x: 5, y: 10 };
    foo(ref p);
    foo(ref p); // this now works even without the Copy trait
    println!("p.x = {}", p.x); // p.x = 7 
}
```
