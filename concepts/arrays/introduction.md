# Introduction

In Cairo, arrays are fundamental data structures designed to store collections of elements of the same type in a structured manner. Similar to lists in other programming languages, each element in an array is accessed by its index, allowing for efficient retrieval and manipulation.

Cairo arrays are immutable data structures. Elements can only be appended to the end or removed from the front of the array. This design ensures data integrity and stability, aligning with Cairo's approach to memory management. Arrays are initialized using `ArrayTrait::new()` and support type-specific declarations for element storage. Accessing elements can be done with `get()` or `at()` methods, while pop_front() allows for front-end element removal. These characteristics make Cairo arrays suitable for structured data storage and retrieval tasks.
