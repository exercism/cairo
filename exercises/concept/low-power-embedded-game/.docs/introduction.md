# Introduction

Tuples are a lightweight way to group a fixed set of arbitrary types of data together. A tuple doesn't have
a particular name; naming a data structure turns it into a `struct`. A tuple's fields don't have names;
they are accessed by means of destructuring or by position.

## Creation

Tuples are always created with a tuple expression:

```rust
// pointless but legal
let unit = ();
// single element
let single_element = ("note the comma",);
// two element
let two_element = (123, "elements can be of differing types");
```

Tuples can have an arbitrary number of elements.

## Access by destructuring

It is possible to access the elements of a tuple by destructuring. This just means assigning variable
names to the individual elements of the tuple, consuming it.

```rust
let (elem1, _elem2) = two_element;
assert_eq!(elem1, 123);
```
