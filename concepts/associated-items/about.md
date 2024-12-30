# Associated Items

Associated items are items declared in traits or defined in implementations.

These include:

- **Associated functions** (like methods)
- **Associated types**
- **Associated constants**
- **Associated implementations**

They group logically related functionality with a type.

For example, the `is_some` method in `Option` is intrinsically tied to `Option`.

## Associated Types

Associated types define placeholders for types in traits, which are specified by implementors.

This keeps trait definitions flexible and concise.

Example:

```rust
trait Pack<T> {
    type Result;

    fn pack(self: T, other: T) -> Self::Result;
}

impl PackU32Impl of Pack<u32> {
    type Result = u64;

    fn pack(self: u32, other: u32) -> Self::Result {
        let shift: u64 = 0x100000000; // 2^32
        self.into() * shift + other.into()
    }
}
```

Here, `Result` is an associated type determined by each implementation.

A function using this trait doesn't need to specify extra generics:

```rust
fn combine<T, impl PackImpl: Pack<T>>(a: T, b: T) -> PackImpl::Result {
    a.pack(b)
}
```

## Associated Constants

Associated constants are fixed values tied to a type and defined in a trait or its implementation.

Example:

```rust
trait Shape<T> {
    const SIDES: u32;
    fn describe() -> ByteArray;
}

struct Triangle {}

impl TriangleShape of Shape<Triangle> {
    const SIDES: u32 = 3;
    fn describe() -> ByteArray {
        "I am a triangle."
    }
}

struct Square {}

impl SquareShape of Shape<Square> {
    const SIDES: u32 = 4;
    fn describe() -> ByteArray {
        "I am a square."
    }
}
```

This ties constants like `SIDES` to `Shape` instead of hardcoding them elsewhere.

## Associated Implementations

Associated implementations enforce relationships between types and traits.

For example:

```rust
// Collection type that contains a simple array
#[derive(Drop)]
pub struct ArrayIter<T> {
    array: Array<T>,
}

// T is the collection type
pub trait Iterator<T> {
    type Item;
    fn next(ref self: T) -> Option<Self::Item>;
}

impl ArrayIterator<T> of Iterator<ArrayIter<T>> {
    type Item = T;
    fn next(ref self: ArrayIter<T>) -> Option<T> {
        self.array.pop_front()
    }
}

/// Turns a collection of values into an iterator
pub trait IntoIterator<T> {
    /// The iterator type that will be created
    type IntoIter;
    impl Iterator: Iterator<Self::IntoIter>;

    fn into_iter(self: T) -> Self::IntoIter;
}

impl ArrayIntoIterator<T> of IntoIterator<Array<T>> {
    type IntoIter = ArrayIter<T>;
    fn into_iter(self: Array<T>) -> Self::IntoIter {
        ArrayIter { array: self }
    }
}
```

This guarantees `Array` can always be converted into an iterator (`IntoIter`), ensuring consistency and type safety.
