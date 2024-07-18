# Introduction
In Cairo, the concept of ownership defines the rules governing how variables behave in the Cairo virtual machine. Each declared variable can only be used once, meaning that once a variable is used, it will either be destroyed or moved, depending on the type of usage.

## Variable Destruction:
   - a variable goes out of scope (with/without usage).
   - a struct is destructured.
   - explicit destruction using `destruct()`

## Variable Movement:
- A move can occur when a value is passed to another function.

 _The Cairo language is linear system programming language that works in such a way that is possible to prove all code with verification alongside abstracting away the immutable memory of the Cairo VM._