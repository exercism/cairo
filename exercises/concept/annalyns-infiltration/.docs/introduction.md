# Introduction

Booleans in Cairo are represented by the predeclared Boolean type `bool`, which values can be either `true` or `false`.

```rust
let speeding = true;   // Boolean variable 'speeding' set to 'true'
let has_error = false; // Boolean variable 'has_error' set to 'false' 
```

Cairo supports three logical operators that can evaluate expressions down to Boolean values, returning either `true` or `false`.

| Operator    | What it means                                 |
| ----------- | --------------------------------------------- |
| `&&` (and)  | It is true if both statements are true.       |
| `\|\|` (or) | It is true if at least one statement is true. |
| `!` (not)   | It is true only if the statement is false.    |
