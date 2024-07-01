# Arrays

An [`Array`][Array] are fixed-size sequences of elements of the same data type. Unlike [`lists`][List], which are dynamic and can hold elements of various types, arrays are homogeneous collections that are more memory-efficient for storing large sets of data when the type is known beforehand. Arrays can be of multiple dimensions, with the simplest form being one-dimensional arrays

# Array Construction

In Python, arrays are primarily constructed using the `array` module from the standard library. They can hold elements of any data type, but all elements in an array must be of the same type.

### Using the `array` Module

The array module provides the array class for creating arrays. You specify the type code for the array elements when creating an array:

```python
import array

# Create an array of integers
int_array = array.array('i', [1, 2, 3, 4, 5])

# Create an array of floating-point numbers
float_array = array.array('f', [1.0, 2.5, 3.7, 4.2])

# Create an array of characters (bytes)
char_array = array.array('b', b'hello')

```

In this example:

- 'i' denotes integers,
- 'f' denotes floats,
- 'b' denotes characters as bytes.

### Using Lists

In Python, the most common way to create arrays is using lists. Lists are flexible and allow you to store elements of different data types, but you can create them with elements of the same type if needed.

```python
# Example: Creating an array (list) of fruits
fruits = ["mango", "apple", "strawberry"]

```

### Using `numpy` Arrays

For more advanced array operations, especially for multi-dimensional arrays and numerical computations, the numpy library is widely used in Python.

```python
import numpy as np

# Create a numpy array of integers
np_int_array = np.array([1, 2, 3, 4, 5])

# Create a numpy array of floats
np_float_array = np.array([1.0, 2.5, 3.7, 4.2])

# Create a numpy array of strings
np_str_array = np.array(['mango', 'apple', 'strawberry'])

```

# Accessing Values in an Array

Elements in an array are accessed using square brackets [] with the index of the element:

```python
# Accessing elements in arrays
print(int_array[0])  # Output: 0
print(float_array[2])  # Output: 2.0
print(char_array[3])  # Output: 108 (ASCII code for 'l')

```

# Changing or Adding Array Values

You can modify the value of an array element by assigning a new value to its index:

```python
# Changing array values
int_array[0] = 100
print(int_array)  # Output: array('i', [100, 1, 2, 3, 4, 5])

# Adding new elements to the array
int_array.append(200)
print(int_array)  # Output: array('i', [100, 1, 2, 3, 4, 5, 200])

```

# Removing Array Elements

Unlike other data structures, arrays in Python do not have built-in methods for removing elements at arbitrary positions efficiently. Typically, elements are marked as deleted or the array is resized and copied to remove elements.

# Looping Through/Iterating over an Array

You can iterate over the elements of an array using a `for` loop:

```python
# Iterating over array elements
for elem in int_array:
    print(elem)

```

Alternatively, you can iterate over the array indices:

```python
# Iterating over array indices
for i in range(len(int_array)):
    print(int_array[i])

```

# Multi-dimensional Arrays

While Python arrays are primarily one-dimensional, you can create arrays of arrays (nested arrays) to simulate multi-dimensional arrays. However, this approach is less common compared to using numpy arrays for multi-dimensional data.

Python lists and numpy arrays can be used to simulate multi-dimensional arrays, numpy provides a more optimized and convenient way to work with them:

```python
import numpy as np

# Create a 2D numpy array (matrix)
matrix = np.array([
                    [1, 2, 3],
                    [4, 5, 6]
                ])

# Create a 3D numpy array
tensor = np.array([
                    [
                        [1, 2],
                        [3, 4]
                    ],
                    [
                        [5, 6],
                        [7, 8]
                    ]
                ])

```
