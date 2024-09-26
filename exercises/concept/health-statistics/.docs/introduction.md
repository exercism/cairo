# Introduction

It is often useful to group a collection of items together, and handle those groups as units. In Cairo, we call such a group a struct, and each item one of the struct's fields. A struct defines the general set of fields available, but a particular example of a struct is called an instance.

Furthermore, structs can have methods defined on them, which have access to the fields. The struct itself in that case is referred to as `self`. When a method uses `ref self: SomeStruct`, the fields can be changed, or mutated. When a method uses `self: SomeStruct` or `self: @SomeStruct`, the fields cannot be changed: they are immutable. Controlling mutability helps the borrow-checker ensure that entire classes of concurrency bugs just don't happen in Cairo.

In this exercise, you'll be implementing two kinds of methods on a struct. The first are generally known as getters: they expose the struct's fields to the world, without letting anyone else mutate that value.

You'll also be implementing methods of another type, generally known as setters. These change the value of the field. Setters aren't very common in Cairo - if a field can be freely modified, it is more common to just make it public - but they're useful if updating the field should have side effects.

Structs are defined using the `struct` keyword, followed by the capitalized name of the type the struct is describing:

```rust
struct Item {}
```

Additional types are then brought into the struct body as _fields_ of the struct, each with their own type:

```rust
struct Item {
    name: String,
    weight: f32,
    worth: u32,
}
```

A trait defines a set of methods that can be implemented by a type (we'll be focusing on structs here, but traits can be implemetned on enums as well). These methods can be called on instances of the type when this trait is implemented. Traits are defined using the `trait` keyword and within traits we define the method signatures we want our type to implement.

```rust
trait ImplTrait {
    // Define the method signature
    fn new() -> Item;
}
```

Lastly, methods can be defined on structs inside of an `impl` block, which implements the defined trait:

```rust
impl ItemImpl of ImplTrait {
    // initializes and returns a new instance of our Item struct
    fn new() -> Item {
        Item {}
    }
}
```
