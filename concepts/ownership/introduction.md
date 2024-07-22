# Introduction
In Cairo, the concept of ownership applies to _variables_ and defines the rules governing who can use those variables. Each declared variable can only be used once, meaning that once a variable is used, it will either be destroyed or moved, depending on the type of usage.

_Destruction_ can happen in several ways:
   - a variable goes out of scope (with/without usage).
   - a struct is destructured.
   - explicit destruction using `destruct()`

_Moving_ a value simply means passing that value to another function.

 _The Cairo language uses a linear type system, which it leverages to ensure that all code is provable (and verifiable) alongside abstracting away the immutable memory of the Cairo VM.