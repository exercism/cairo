# Modules and Paths in Cairo

Cairo uses **modules** to organize code.

Modules help structure projects and control visibility of items like functions, structs, and traits.

## Defining Modules

Modules are defined with `mod` and can be nested:

```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}
```

Functions, structs, and traits are **private by default**.

Use `pub` to make them accessible outside their module.

## Paths: Absolute vs Relative

To refer to an item in another module, you can use:

- **Absolute paths** (starting from `crate::`):
  ```rust
  crate::front_of_house::hosting::add_to_waitlist();
  ```
- **Relative paths** (starting from the current module):
  ```rust
  front_of_house::hosting::add_to_waitlist();
  ```
  This works if `front_of_house` is in the same module.

## Bringing Modules into Scope with `use`

Writing full paths repeatedly is inconvenient.

The `use` keyword allows shorter references:

```rust
use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist(); // Shorter path
}
```

`use` applies **only in the scope where it appears**; if needed elsewhere, it must be repeated.

### Idiomatic Use of `use`

- Bring **modules** into scope, not functions:
  ```rust
  use crate::front_of_house::hosting; // ✅
  hosting::add_to_waitlist();
  ```
  Instead of:
  ```rust
  use crate::front_of_house::hosting::add_to_waitlist; // ❌
  add_to_waitlist();
  ```
- For **traits, structs, and enums**, use the full path:
  ```rust
  use core::num::traits::BitSize;
  ```

### Aliases with `as`

Rename imports when necessary:

```rust
use core::array::ArrayTrait as Arr;

fn main() {
    let mut arr = Arr::new();
    arr.append(1);
}
```

### Importing Multiple Items

Instead of multiple `use` statements, group imports:

```rust
use shapes::{Square, Circle, Triangle};
```

## Re-exporting with `pub use`

To expose a module in a different structure, use `pub use`:

```rust
pub use crate::front_of_house::hosting;
```

Now external code can use `restaurant::hosting::add_to_waitlist()` instead of `restaurant::front_of_house::hosting::add_to_waitlist()`.

## Using External Packages with Scarb

To add a dependency, update `Scarb.toml`:

```toml
[dependencies]
alexandria_math = { git = "https://github.com/keep-starknet-strange/alexandria.git" }
```

Use `scarb add <package>` to add dependencies and `scarb rm <package>` to remove them.

## The Glob Operator (`*`)

To import everything from a module:

```rust
use core::num::traits::*;
```

This should be used carefully, as it can make code harder to read.
