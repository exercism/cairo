# Introduction

## Arrays

The Cairo core library implements an `Array` type. It is similar to the usual array types found in other programming languages, but with a few key differences:

- Elements can be efficiently added only to the back of the `Array` type, and they can only be efficiently removed from the front.
- It is impossible to manually set an item using the array index.

Arrays can be created using the `ArrayTrait::new` function and also the `array!` macro:

```rust
let empty: Array<u32> = ArrayTrait::new();
let one_to_four = array![1, 2, 3, 4];
```

Elements can be added to the array using the `ArrayTrait::append` function:

```rust
let mut num_array = array![1, 2, 3, 4];
num_array.append(5);
// -> [1, 2, 3, 4, 5]
```

Elements can be removed from the array using the `ArrayTrait::pop_front` function:

```rust
let mut one_to_four = array![1, 2, 3, 4];

one_to_four.pop_front();
// -> [2, 3, 4]
```

Cairo also introduces a `Span` type that acts like a "snapshot" of the `Array`.

Every `Array` can be converted into a `Span` with the `ArrayTrait::span` function:

```rust
let one_to_four = array![1, 2, 3, 4];
let one_to_four_span = one_to_four.span();
// -> [1, 2, 3, 4]
```

Converting an array into a `Span` is very efficient, as `Span` is just a data structure that allows Cairo to "view" a section of the array, it doesn't modify it in any way.
 
By converting an array into a `Span`, Cairo allows more operations to be performed than would be permitted on `Array` directly, like removing an item from the front of the span.

```rust
let one_to_four = array![1, 2, 3, 4];
let mut one_to_four_span = one_to_four.span();
one_to_four_span.pop_back();
// -> [2, 3, 4]
```

Note that we had to make `one_to_four_span` mutable with the `mut` keyword in order to invoke `pop_back`, which mutates the span by shortening the section of the array the span is "viewing".
