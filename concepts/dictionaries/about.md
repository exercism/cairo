# Dictionaries

Dictionaries in Cairo are key-value stores similar to maps or hash tables in other languages.

However, they have some unique characteristics due to Cairo's immutable memory model.

## Core Concept

The `Felt252Dict<T>` type provides dictionary functionality in Cairo with `felt252` as the key type and any supported type `T` as the value type.

```rust
use core::dict::Felt252Dict;

fn main() {
    let mut balances: Felt252Dict<u64> = Default::default();
    balances.insert('Alice', 100);
    let balance = balances.get('Alice'); // Returns 100
}
```

## Important Characteristics

Unlike dictionaries in other languages, Cairo dictionaries have some special properties:

1. Keys must be `felt252` values.
2. All keys implicitly start with a value of zero.
3. You cannot delete entries - you can only update values.
4. Values must implement the `Felt252DictValue` trait.

## Performance Note

Due to Cairo's immutable memory model, dictionary operations have $O(n)$ complexity where $n$ is the number of operations performed on the dictionary.

Each operation creates a new entry recording the change.

## Working with Complex Types 

For types that don't implement `Felt252DictValue` (like arrays or structs), you can wrap them in `Nullable<T>`:

```rust
let mut dict: Felt252Dict<Nullable<Span<felt252>>> = Default::default();
dict.insert(0, NullableTrait::new(array![1, 2, 3].span()));
```

## Memory Management

Dictionaries implement the `Destruct` trait, which means they are automatically "squashed" (validated and optimized) when they go out of scope.

This is part of Cairo's proof system and happens behind the scenes.

Remember: While dictionaries may seem less efficient than in other languages, they're designed this way to work with Cairo's unique memory model and proof system requirements.
