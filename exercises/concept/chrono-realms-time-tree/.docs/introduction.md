# Introduction

Smart pointers in Cairo are advanced data structures that ensure safe and efficient memory management by adding safety features to regular pointers, preventing common issues like dereferencing null pointers or accessing uninitialized memory.

## What is a Smart Pointer?

A smart pointer behaves like a regular pointer but tracks ownership and ensures safe memory access, preventing issues like null or dangling pointer dereferencing.

## Types of Smart Pointers

Cairo provides several smart pointer types, such as `Box<T>` and `Nullable<T>`:

- **`Box<T>`**: Stores data in a special memory segment, ideal for large or dynamically-sized data. It allows transferring ownership without copying the data.
- **`Nullable<T>`**: Points to either a valid value of type `T` or `null`, useful for handling optional values.

## Memory Safety

Smart pointers help prevent unsafe memory access, ensuring memory is automatically deallocated when no longer needed, thus reducing the risk of memory leaks.

### Example: Using `Box<T>` for Recursive Types

Smart pointers like `Box<T>` allow for safe handling of recursive types, such as in a binary tree, by allocating memory efficiently and avoiding infinite recursion.

```rust
use core::box::{BoxTrait};

#[derive(Copy, Drop)]
enum BinaryTree {
    Leaf: u32,
    Node: (u32, Box<BinaryTree>, Box<BinaryTree>),
}

fn main() {
    let leaf1 = BinaryTree::Leaf(1);
    let leaf2 = BinaryTree::Leaf(2);
    let node = BinaryTree::Node((3, BoxTrait::new(leaf1), BoxTrait::new(leaf2)));
    println!("{:?}", node);
}
```

## Performance Benefits

Smart pointers improve performance by passing references to data instead of copying large structures, reducing memory overhead.

```rust
// `Cart` is a large struct that contains a lot of information
fn pass_pointer(cart: Box<Cart>) {
    let cart = cart.unbox();
    println!("{} is shopping today and bought {} items", cart.buyer, cart.items);
}
```
