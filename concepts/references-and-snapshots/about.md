# References and Snapshots

When you pass a variable to a function, it's ownership is usually transferred, making the original variable unusable, this can be a bit tedious when accessing a state more than once.
Cairo has two features for passing a value without destroying or moving it, called `references` and `snapshots`.

## Snapshots

Snapshots provide an immutable view of a value at a certain point in time, allowing you to retain ownership of a variable while accessing its state.
Any modification to the variable creates a new memory cell, leaving the snapshot's view unchanged.

```rust
fn get_len(arr: @Array<u128>) -> u32 { // this parameter takes in a snapshot using `@` with the data-type
    arr.len()
}

fn foo(arr: Array<u128>) {
    arr.pop_front();
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8];
    let snapshot = @new_arr; // using `@` to create a snapshot of a variable
    let len = get_len(snapshot); // pass the snapshot as argument, retaining ownership
    foo(new_arr); // `new_arr` is still valid up until here and no further

    // let new_len = new_arr.len(); // this would throw an error if you uncommented the code because `new_arr` has been moved when it was passed into `foo()` above
}
```

## Desnap Operator

To convert a snapshot back into a regular variable, you can use the desnap operator `*`, which serves as the opposite of the `@` operator.
Only those types that implement the `Copy` trait can be desnapped.

```rust
#[derive(Drop)]
struct Rectangle {
    height: u64,
    width: u64,
}

fn main() {
    let rec = Rectangle { height: 3, width: 10 };
    let area = calculate_area(@rec);
    println!("Area: {}", area);
}

fn calculate_area(rec: @Rectangle) -> u64 {
    // We need to transform the snapshots back into values using the desnap operator `*`.
    // Here we use `*` to both multiply the height and width and to desnap the snapshots.
    *rec.height * *rec.width
}
```

## Mutable References

Mutable references allow you to pass mutable values to a function and have them implicitly returned, maintaining ownership in the calling context.
This can be achieved using the `ref` modifier, provided the variable is declared as mutable with the `mut` keyword.

```rust
fn foo(ref arr: Array<u128>) { // using `ref` marks the argument as a mutable reference
    arr.pop_front(); // modifies the state of arr
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8];

    foo(ref new_arr);  // use `ref` to pass a mutable reference to the function

    let new_len = new_arr.len();  // the current context retains ownership of `new_arr`, so we can still use it
}
```
