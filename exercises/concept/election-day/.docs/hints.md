# Hints

## General

- Struct instances are created by declaring the struct name followed by field values enclosed in curly brackets.
- `@T` can be used to declare snapshots of some type `T`, e.g `let i: @u32 = @1;` declares a variable `i` that is a snapshot of the `u32` value `1`;
- You can extract a value from a snapshot by using the `*` (desnap) operator, e.g `let int = *an_int_snapshot;`.
- You can declare a value as mutable by using the `mut` keyword, like `let mut i = 1;`.

## 1. Create a vote counter

- You need to create a pointer to a `VoteCounter` struct, in other words, a `@VoteCounter`.
- You can assign the `value` parameter directly when creating a struct instance.

## 2. Get number of votes from a counter

- You can use the `*` operator on a snapshot to desnap it and get its value, e.g `*my_snapshot`

## 3. Increment the votes of a counter

- To get the current value of the `VoteCounter` snapshot, you need to desnap it using the `*` operator, or call the function you made in the previous task.
- Instead of modifying the `VoteCounter` instance, you need to return a new instance of `VoteCounter` with votes incremented.

## 4. Create the election results

- Create a new `ElectionResult` struct or variable with the fields `name` and `vote_counter` filled with the values in the arguments of the function.
- You can create a `VoteCounter` snapshot by using the `@` operator before the variable name/struct declaration, or call the `new_vote_counter` function you made in one of the previous tasks.

## 5. Announce the results

- Although you are receiving a snapshot to an `ElectionResult`, you can access its fields with the dot `.` notation, like if it wasn't a snapshot!
- Build the message by accessing the `name` and `vote_counter` fields on the struct.
- When desnapping a nested snapshot, you need to apply as many `*` operators as there are snapshots to desnap:

```rust
let result = @ElectionResult {
    name: "John",
    vote_counter: @VoteCounter { value: 32 },
};

println!("{}", **result.vote_counter.value); 
// => 32
```

## 6. Vote recounting

- Because of the [way dictionaries are implemented][dictionaries underneath], it is a requirement that they be mutable to both modify and read from them, which means that changes you make to the dictionary inside the function will be visible outside the function.
- To increment the value of a key in a `let mut m: Felt252Dict<u32>`, you should combine its `get` and `insert` functions: `m.insert('mykey', m.get('mykey') + 1);`

[dictionaries underneath]: https://book.cairo-lang.org/ch03-02-dictionaries.html#dictionaries-underneath
