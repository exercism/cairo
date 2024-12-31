# Method Syntax

Methods in Cairo are similar to functions, but they are tied to a specific type through traits.

Their first parameter is always `self`, representing the instance on which the method is called.

While Cairo doesn’t allow defining methods directly on a type, you can achieve the same functionality by defining a trait and implementing it for the type.

Here’s an example of defining a method on a `Rectangle` type using a trait:

```rust
#[derive(Copy, Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
}

fn main() {
    let rect = Rectangle { width: 30, height: 50 };
    println!("Area is {}", rect.area());
}
```

In the example above, the `area` method calculates the area of a rectangle.

Using the `#[generate_trait]` attribute simplifies the process by automatically creating the required trait for you.

This makes your code cleaner while still allowing methods to be associated with specific types.

## Associated Functions

Associated functions are similar to methods but don’t operate on an instance of a type—they don’t take `self` as a parameter.

These functions are often used as constructors or utility functions tied to the type.

```rust
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn square(size: u64) -> Rectangle {
        Rectangle { width: size, height: size }
    }
}

fn main() {
    let square = RectangleTrait::square(10);
    println!("Square dimensions: {}x{}", square.width, square.height);
}
```

Associated functions, like `Rectangle::square`, use the `::` syntax and are namespaced to the type.

They make it easy to create or work with instances without requiring an existing object.

By organizing related functionality into traits and implementations, Cairo enables clean, modular, and extensible code structures.
