# Arrays

In Cairo, an array is a data structure that allows you to store a collection of elements of the same type. Arrays in Cairo have limited modification options. You can only append items to the end of an array and remove items from the front. Arrays are, in fact, queues whose values can't be modified.

## Array Construction

Arrays are primarily constructed using the `ArrayTrait` trait, using any of the following 4 ways to construct an array of elements `[1, 2]`:

```rust
// 1. Passing the type to the `ArrayTrait`
let mut arr_type_in_trait = ArrayTrait::<felt252>::new();
arr_type_in_trait.append(1);
arr_type_in_trait.append(2);

// 2. Setting the type on the variable itself
let mut arr_explicit_type: Array<felt252> = ArrayTrait::new();
arr_explicit_type.append(1);
arr_explicit_type.append(2);

// 3. Using the `array!` macro
let mut arr_from_macro: Array<felt252> = array![1, 2]; // assign values in-line

// 4. Allowing the compiler to infer the type from the type of values being assigned to it
let mut arr_implicit_type = ArrayTrait::new(); // compiler "knows" this is a `felt252` array
arr_implicit_type.append(1);
arr_implicit_type.append(2);
```

> Each `append()` call puts a new number at the end of the array. 

## Removing Array Elements

The only way to remove elements from an array in Cairo is from the front. This operation is facilitated by the `pop_front()` method, which returns an `Option` that can be unwrapped, containing the removed element, or `Option::None` if the array is empty.

```rust
fn main() {
    let mut a = array![10, 1, 2];
    let first_value = a.pop_front().unwrap(); // `unwrap()` is used to get the value from `Option`
    println!("The first value is {}", first_value); // prints "The first value is 10"
}
```

## Accessing Values in an Array

To access array elements, you can use `get()` or `at()` array methods that return different types. An equivalent to `arr.at(index)` is the subscripting operator `arr[index]`.

### Using get() Method

The `get()` method is like looking up an item in a list by its number.
Here’s how it works:

- `arr.get(index)` allows you to fetch an item at a specific position (index) in the array.
- It returns an `Option::Some(value)` if the item at the given index exists, or `Option::None` if the index is out of bounds.

This method is ideal when you want to handle cases where the index might be invalid without causing your program to crash.

```rust
fn main() {
    let arr: Array<u32> = array![1, 2, 3];

    let index = 1;

    match arr.get(index) {
        Option::Some(value) => { println!("Element at index {}: {}", index, value.unbox()); },
        Option::None => { println!("Index {} is out of bounds!", index); }
    }
}
```

### Using at() Method

The `at()` method directly gives you a snapshot of the element at a specific index using the `unbox()` operation to extract the stored value from the box. A shorthand for this method is using the subscripting operator `arr[index]`. If you try to access an index that doesn't exist (out-of-bounds), the program will panic with an error.

```rust
fn main() {
    let a: Array<u32> = array![5, 8];

    println!("First: {}", *a.at(0)); // prints "First: 5"
    println!("Second: {}", a[1]); // prints "Second: 8"
    println!("Third: {}", a[2]); // panics with 'Index out of bounds'
}
```

## Size-related Methods

To determine the number of elements in an array, use the `len()` method. The return value is of type `usize`.

If you want to check if an array is empty or not, you can use the `is_empty()` method, which returns `true` if the array is empty and `false` otherwise.

## `Span`

`Span` is a struct that represents a snapshot of an `Array`. It is designed to provide safe and controlled access to the elements of an array without modifying the original array. `Span` is particularly useful for ensuring data integrity and avoiding borrowing issues when passing arrays between functions or when performing read-only operations.

> All methods provided by `Array` can also be used with `Span`, except for the `append()` method.

To create a `Span` of an `Array`, call the `span()` method:

```rust
let my_array: Array<u32> = array![1, 2, 3];
let my_span: Span<u32> = my_array.span();
```

## The Fixed Size `Array` Type

We write the values in a fixed-size array as a comma-separated list inside square brackets. The array’s type is written using square brackets with the type of each element, a semicolon, and then the number of elements in the array.

```rust
let arr: [u64; 5] = [1, 2, 3, 4, 5];
```

> Note: only fixed size arrays can be used as constants

Elements in a fixed size array can be accessed either by deconstructing the array or by converting it into a `Span`, which supports indexing.

```rust
fn main() {
    let arr = [1, 2, 3, 4, 5]; // implicit `felt252` array type

    // Accessing elements of a fixed-size array by deconstruction
    let [a, b, c, _, _] = arr;
    println!("c: {}", c); // c: 3
    
    // Accessing elements of a fixed-size array by index
    let my_span = arr.span();
    println!("my_span[2]: {}", my_span[2]); // my_span[2]: 3
}
```

