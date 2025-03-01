# Introduction

Cairo provides dictionaries as part of its core libraries represented by the `Felt252Dict<T>` type.

The dictionary key type in Cairo is restricted to `felt252`, which differs from other languages where it is possible to define the type of the key type. 

To create a dictionary, you can use the `default` method of the `Default` trait, like:

```rust
let mut foo: Felt252Dict<u32> = Default::default();
```

The basic operations that are most often used are:

1. `insert(felt252, T) -> ()` to write values to a dictionary instance and
2. `get(felt252) -> T` to read values from it.

And here's how you would use these operations:

```rust
let mut foo: Felt252Dict<u32> = Default::default();
// Add a value to the dictionariy
foo.insert('bar', 42);
// Here we update the element of 'bar'
foo.insert('bar', 73);
// To retrieve a dictionary value, you can use
baz = foo.get('bar');
```

If you try to retrieve the value for a key which does not exist in the dictionary, it will return the zero value of the value type.

This can confuse you, especially if the default value of your value type (for example, 0 for an integer), is a valid value.

This also means there is no way to delete data from a dictionary.

Something to take into account when incorporating this structure into your code.
