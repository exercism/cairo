# references-and-snapshot
When you pass a variable to a function, it's ownership is usually transferred, making the original variable unusable, this can be a bit tedious when accessing a state more than once. Cairo has two features for passing a value without destroying or moving it, called `references` and `snapshots`.

## Snapshot
Snapshots provide an immutable view of a value at a certain point in time, allowing you to retain ownership of a variable while accessing its state.
A snapshot is a view of a value that cannot be modified. Any modification to the variable creates a new memory cell, leaving the snapshot's view unchanged.

```rust
fn get_len(arr: @Array<u128>) -> u32 { //this parameter takes in a snapshot using `@` with the data-type
    arr.len()
}
fn foo(arr: Array<u128>) {
    arr.pop_front();
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8]; //Declaration of array
    let snapshot = @new_arr; // Use `@` to create a snapshot of a variable
    let len = get_len(snapshot); //pass the snapshot as arguement retaining ownership
    foo(new_arr); // `new_arr` is still valid up until here and no further
    
    // let new_len = new_arr.len(); // This will throw an error when you uncomment the code because `new_arr` has been moved in the logic above
}
```
Declare an array `new_arr`, then create a snapshot of it using the `@` symbol to inspect the array without moving ownership. Obtain the length of the snapshot with `get_len(snapshot)`. Pass `new_arr` to function `foo`, which moves the array and renders `new_arr` invalid for further use.

## Desnap Operator:
To convert a snapshot back into a regular variable, you can use the desnap operator `*`, which serves as the opposite of the `@` operator.
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
    // As rec is a snapshot to a Rectangle, its fields are also snapshots of the fields types.
    // We need to transform the snapshots back into values using the desnap operator `*`.
    // This is only possible if the type is copyable, which is the case for u64.
    // Here, `*` is used for both multiplying the height and width and for desnapping the snapshots.
    *rec.height * *rec.width
}
```

## Mutable References
Mutable references allow you to pass mutable values to a function and have them implicitly returned, maintaining ownership in the calling context. This can be achieved using the `ref` modifier, provided the variable is declared as mutable with `mut`.

```rust
fn get_len(arr: @Array<u128>) -> u32 { // the parameter takes in a snapshot
    arr.len() //assessing the state of arr without modifying
}
fn foo(ref arr: Array<u128>) { //use the ref modifier in accepting argument

    arr.pop_front(); // modifies the state of arr
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8]; //Declaration of array
    let snapshot = @new_arr; // Use `@` to create a snapshot of a variable
    let len = get_len(snapshot);
    foo(ref new_arr);  // Use `ref` to pass a mutable reference to a function.
    
    let new_len = new_arr.len();  // access the new length of  new_arr
}
```
 By using mutable references, you can modify values within functions while retaining ownership in the original scope.
