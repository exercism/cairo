# Introduction

Generics allow you to write code that works with multiple types without duplication.
You define generic types using angle brackets `<T>` where `T` is a placeholder for any type.

```rust
fn largest_list<T>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}
```

However, Cairo requires trait bounds to specify what operations the generic type must support.
You can add constraints using the `+` syntax:

```rust
fn process_data<T, +Drop<T>, +Copy<T>>(value: T) -> T {
    // Function body
}
```

Structs can also be generic:

```rust
#[derive(Drop)]
struct Container<T> {
    value: T,
}
```

Traits can be generic too, allowing them to work with different types:

```rust
trait Processor<T> {
    fn process(self: @T) -> ByteArray;
}

impl MyProcessor<T, +Drop<T>> of Processor<T> {
    fn process(self: @T) -> ByteArray {
        "processed"
    }
}
```

Functions can accept generic parameters with trait bounds, making them work with any type that implements the required trait:

```rust
fn use_processor<T, +Processor<T>, +Drop<T>>(item: T) -> ByteArray {
    item.process()
}
```
