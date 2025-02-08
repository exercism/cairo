# Introduction

In Cairo, operator overloading allows you to define custom behavior for standard operators like `+`, `-`, `==`, `<`, etc., when working with your own types.

This is done by implementing specific traits for your custom types.

## Core Traits for Operators

### `Add` and `Sub`

The `Add` and `Sub` traits allow you to define how addition (`+`) and subtraction (`-`) work with your type:

```rust
impl MyTypeAdd of Add<MyType> {
    fn add(lhs: MyType, rhs: MyType) -> MyType {
        // Define addition behavior
    }
}
```

### `PartialEq`

The `PartialEq` trait enables equality comparison (`==` and `!=`) between instances of your type.

This can often be automatically derived using `#[derive(PartialEq)]`.

### `PartialOrd`

The `PartialOrd` trait allows for comparison operations (`<`, `>`, `<=`, `>=`) between instances of your type.

It requires you to implement at least the `lt` (less than) method:

```rust
impl MyTypePartialOrd of PartialOrd<MyType> {
    fn lt(lhs: MyType, rhs: MyType) -> bool {
        // Define "less than" behavior
    }
}
```
