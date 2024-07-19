# Mutability

Cairo, with its blockchain-oriented design, implements an immutable memory model by default. This means that once a value is written into memory, it cannot be overwritten, only read. However, Cairo provides a mechanism to create mutable variables using the `mut` keyword. When a variable is declared as mutable, and the value is changed, the new value is written to a new memory cell, and the variable is updated to point to the new cell. This mechanism allows for flexibility while maintaining the benefits of immutability.
