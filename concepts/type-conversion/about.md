# Type Conversion

Cairo supports type conversion through the `Into` and `TryInto` traits from the core library, commonly used for in-built and custom types.

These traits define methods for converting values between types:  

- **`Into`**: Used for guaranteed, infallible conversions.  
- **`TryInto`**: Used for fallible conversions, returning `Option<T>`.

## Using `Into`

`Into` handles conversions where the target type can always accommodate the source value.

```rust
fn main() {
    let my_u8: u8 = 10;
    let my_felt252: felt252 = my_u8.into(); // Infallible conversion
    let my_u256: u256 = my_felt252.into(); // Conversion to larger types
}
```

## Using `TryInto`

`TryInto` is for cases where the conversion might fail, returning `Option<T>`.

```rust
fn main() {
    let my_u256: u256 = 10;
    let my_felt252: felt252 = my_u256.try_into().unwrap(); // Success
    let my_large_u16: u16 = 2048;
    let my_large_u8: u8 = my_large_u16.try_into().unwrap(); // Panics because value doesn't fit in `u8`
}
```

## Custom Type Conversion

You can implement these traits for your own types.  

### Example: `Into`

```rust
#[derive(Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

#[derive(Drop)]
struct Square {
    side_length: u64,
}

impl SquareIntoRectangle of Into<Square, Rectangle> {
    fn into(self: Square) -> Rectangle {
        Rectangle { width: self.side_length, height: self.side_length }
    }
}
```

### Example: `TryInto`

```rust
impl RectangleIntoSquare of TryInto<Rectangle, Square> {
    fn try_into(self: Rectangle) -> Option<Square> {
        if self.height == self.width {
            Option::Some(Square { side_length: self.height })
        } else {
            Option::None
        }
    }
}
```

This setup provides flexible and type-safe conversions for both built-in and custom types in Cairo.
