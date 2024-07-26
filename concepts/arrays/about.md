# Arrays

In Cairo, an array is a data structure that allows you to store a collection of elements of the same type. Arrays in Cairo have limited modification options. You can only append items to the end of an array and remove items from the front. Arrays are, in fact, queues whose values can't be modified.

## Why Can't You Change Items in an Array?

This limitation exists because, in Cairo, memory access is immutable, meaning that once you store something in a memory slot, you can't directly change or delete it. You can only read what's in the memory slot or put something new into another slot. This ensures that stored data remains secure and consistent, preventing accidental alterations.

## Array Construction

Arrays are primarily constructed using the `ArrayTrait` trait, by calling `ArrayTrait::new()`. This sets up the array for you to start adding elements.

```rust
let mut arr = ArrayTrait::new();
arr.append(0);
arr.append(1);
arr.append(2);
```

- "num" implies a numerical value; "arr" implies an array
- compiler will complain if you instantiate an array like this without specifying the type; but if you append an item after instantiating like in the suggestion, the compiler will infer the array's type based on the items you appended

When you create an array, you can tell the compiler what data type it will hold. You can do this by passing the expected type of items inside the array when instantiating it, or by explicitly defining the type of the variable.

```rust
let mut arr = ArrayTrait::<u128>::new();
let mut arr: Array<u128> = ArrayTrait::new();
```

## Adding Array Values

Once you have an array, you can add elements to it. In our example, we're adding three numbers: `0`, `1`, and `2`.

```rust
arr.append(0);
arr.append(1);
arr.append(2);
```

Each `append()` call puts a new number at the end of the array. So, after these operations, `arr` will contain `[0, 1, 2]`.

If you attempt to append an item of a type that's different than the one the array expects, it will typically cause a type error and fail to compile.

## Removing Array Elements

The only way to remove elements from an array in Cairo is from the front. This operation is facilitated by the `pop_front()` method, which returns an `Option` that can be unwrapped, containing the removed element, or `Option::None` if the array is empty.

Let's walk through an example to illustrate how this works:

```rust
fn main() {
    // Assume we have an array-like structure called `a`
    let mut a = ArrayTrait::new();

    // Add some elements to the array
    a.append(10);
    a.append(1);
    a.append(2);

    // Remove the first element from the front of the array
    let first_value = a.pop_front().unwrap(); // `unwrap()` is used to get the value from `Option`

    // Print the removed value
    println!("The first value is {}", first_value);
}
```

The `pop_front()` method is used to remove the first element from the front of the array. In this case, `10` is removed.

`pop_front()` returns an `Option`. This allows for handling situations where the array might be empty (we will show how this can be done later in the course).

`unwrap()` is used here assuming the array isn't empty, directly retrieving the value of the removed element (`10`). In real-world scenarios, error handling would typically be more robust.

## Accessing Values in an Array

To access array elements, you can use `get()` or `at()` array methods that return different types. An equivalent to `arr.at(index)` is the subscripting operator `arr[index]`.

### Using get() Method

The `get()` method is like looking up an item in a list by its number.
Here’s how it works:

- `arr.get(index)` allows you to fetch an item at a specific position (index) in the array.
- It returns an Option, which means:
  Some(value): If the item exists at index, it gives you the value of that item.
  None: If the index is out of bounds or doesn't exist in the array.
- This method is ideal when you want to handle cases where the index might be invalid without causing your program to crash.

```rust
fn main() {
    // Create an array to hold unsigned 128-bit integers
    let mut arr = ArrayTrait::<u128>::new();

    // Add an element to the array
    arr.append(18);

    // Define the index to access (change this to see different results)
    let index_to_access = 1;

    // Use match to handle the result of accessing the element at the specified index
    match arr.get(index_to_access) {
        Option::Some(value) => {
            // Print the value if the element exists at the index
            println!("Element at index {}: {}", index_to_access, value.unbox());
        },
        Option::None => {
            // Panic with a message if the index is out of bounds
            panic!("Index {} is out of bounds!", index_to_access);
        }
    }
}
```

### Using at() Method

The `at()` method directly gives you a snapshot of the element at a specific index using the `unbox()` operation to extract the stored value from the box. If you try to access an index that doesn't exist (out-of-bounds), the program will panic with an error. This method is useful when you want your program to stop if it encounters an unexpected situation like accessing an invalid index.

Here's an example:

```rust
fn main() {
    // Assume we have an array-like structure called `ArrayTrait`
    let mut a = ArrayTrait::new();

    // Add some elements to the array
    a.append(0);
    a.append(1);

    // Access elements using `at()` method
    let first = *a.at(0);  // Access element at index 0
    let second = *a.at(1); // Access element at index 1

    // Now `first` will be 0 and `second` will be 1

}
```

When using the subscripting operator arr[index] instead of arr.at(index), it's essential to explicitly specify the element type of the array. Failure to do so will result in compilation errors.

```rust
fn main() {
    // Assuming Array<felt252> is a custom type supporting dynamic resizing
    let mut a = Array::<felt252>::new(); // Creating a new instance of Array<felt252>

    // Adding elements to the array-like structure
    a.append(0); // Appending the number 0
    a.append(1); // Appending the number 1

    // Accessing elements using subscripting operator []
    let first = a[0]; // Accessing the first element
    let second = a[1]; // Accessing the second element

    // Printing the accessed elements
    println!("First element: {}", first);
    println!("Second element: {}", second);
}
```
