# Arrays

In Cairo, an `array` is a data structure that allows you to store a collection of elements of the same type. It's similar to list where each element is identified by an index. Arrays in Cairo have limited modification options. You can only append items to the end of an array and remove items from the front.

# Why Can't You Change Items in an Array?

This limitation is because of how memory works. Once you store something in a memory slot (like putting an item in a box), you can't directly change or delete it. You can only read what's in the box or put something new into another box. This ensures that stored data remains secure and consistent, preventing accidental alterations.

# Array Construction

Arrays are primarily constructed using the `ArrayTrait` module from the standard library. They are like a container where you can store multiple items of the same type in a structured way.

### Using the `ArrayTrait` Module

To create an array using ArrayTrait, you first need to call `ArrayTrait::new()`. This sets up the array for you to start adding elements.

```
let mut num = ArrayTrait::new();
```

In this example:

`num` is the name of our array.

#### 1. Specifying Element Type

When you create an array, you can tell the computer what kind of things (or data types) will go inside it. For example, if you know you want to store large numbers, you can say `u128`, which means "unsigned 128-bit integer".

You can do it like this:

```
let mut arr = ArrayTrait::<u128>::new();

```

Here, `arr` will hold numbers that are very big but can't be negative.

#### 2. Explicitly Defining Type

If you're being very clear about what your program does, you might also say what type of things go into the array:

```
let mut arr: Array<u128> = ArrayTrait::new();

```

This tells the computer to expect an array that holds big numbers (`u128`), and you're calling it `arr`.

# Adding Array Values

Once you have an array, you can add elements to it. In our example, we're adding three numbers: 0, 1, and 2.

```
num.append(0);
num.append(1);
num.append(2);

```

Each `append()` call puts a new number at the end of the array. So, after these operations, a will contain `[0, 1, 2]`.

If you attempt to append a string (`str`) into an array that is supposed to hold integers (`int num`), it would typically cause a type error or fail to compile.

# Accessing Values in an Array

To access array elements, you can use `get()` or `at()` array methods that return different types.

#### 1. Using get() Method:

The get() method is like looking up an item in a list by its number.
Here’s how it works:

- arr.get(index) allows you to fetch an item at a specific position (index) in the array.
- It returns an Option, which means:
  Some(value): If the item exists at index, it gives you the value of that item.
  None: If the index is out of bounds or doesn't exist in the array.
- This method is ideal when you want to handle cases where the index might be invalid without causing your program to crash.

```
fn main() {
    // Create an array to hold unsigned 128-bit integers
    let mut age = ArrayTrait::<u128>::new();

    // Add an element to the array
    age.append(18);

    // Define the index to access (change this to see different results)
    let index_to_access = 1;

    // Use match to handle the result of accessing the element at the specified index
    match arr.get(index_to_access) {
        Option::Some(value) => {
            // Print the value if the element exists at the index
            println!("Element at index {}: {}", index_to_access, *value);
        },
        Option::None => {
            // Panic with a message if the index is out of bounds
            panic!("Index {} is out of bounds!", index_to_access);
        }
    }
}

```

#### 2. Using at() Method:

The at() method directly gives you the value of an element at a specific position in an array-like structure. It uses an unbox() operation to extract the stored value from a container. If you try to access an index that doesn't exist (out-of-bounds), the program will crash with an error. This method is useful when you want your program to stop if it encounters an unexpected situation like accessing an invalid index.

Here's an example:

```markdown
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

# Removing Array Elements

The only way to remove elements from an array in Cairo is from the front. This operation is facilitated by the pop_front() method, which removes and returns the first element of the array.

Let's walk through an example to illustrate how this works:

```
fn main() {
    // Assume we have an array-like structure called `ArrayTrait`
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

The `pop_front()` method is used to remove the first element from the front of the array. In this case, 10 is removed.

`pop_front()` returns an Option. This allows for handling situations where the array might be empty (though not shown explicitly here).

`unwrap()` is used here assuming the array isn't empty, directly retrieving the value of the removed element (10). In real-world scenarios, error handling would typically be more robust.
