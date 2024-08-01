# Introduction

Tuples are a fundamental compound data type in Cairo, providing an efficient way to group related data of different types into a single, fixed-length structure. This allows you to manage and access related data seamlessly. Here are a couple of examples to illustrate their usage:

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
