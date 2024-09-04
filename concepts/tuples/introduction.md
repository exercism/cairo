# Introduction

Tuples are a lightweight way to group a fixed set of arbitrary types of data together. Tuples can have an arbitrary number of elements. You can access the elements by destructuring.

```rust
fn main() {
    let tup: (u32, u64, bool) = (10, 20, true);
}

fn main() {
    let (x, y, z) = (500, 6, true);

    if y == 6 {
        println!("y is 6!");
    }
}
