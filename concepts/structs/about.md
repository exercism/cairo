# Structs

Structs are custom data types that let you name and package together multiple related values. They are similar to tuples, but more flexible and let you name each piece of data, making your code clearer.
Structs in Cairo have these properties:

- Every struct type has a particular name.
- Every member of a struct is called a **field**.
- Every field of a struct has a particular name.
- Visibility is tracked at the field level: each field may be independently public or private.

## Defining and Instantiating Structs

To define a struct, use the `struct` keyword followed by a name and curly braces containing the fields with their names and types:

```rust
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}
```

To create an instance of a `struct`, specify the `struct` name and use curly braces with key-value pairs for the fields. Note that you can list the fields in any order when creating an instance:

```rust
let user1 = User {
   active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};

let user2 = User {
    sign_in_count: 1, username: "someusername123", active: true, email: "someone@example.com"
};
```

## Interacting with an Instance of a Struct

Use dot notation to access or modify the fields of a `struct` instance. Note that to modify a field, the instance must be mutable:

```rust
let mut user1 = User {
    active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};
user1.email = "anotheremail@example.com";
```

As with any expression, we can construct a new instance of the `struct` as the last expression in the function body to implicitly return that new instance:

```rust
fn build_user(email: ByteArray, username: ByteArray) -> User {
    User {
        email: email,
        username: username,
        active: true,
        sign_in_count: 1,
    }
}
```

## Field Init Shorthand

In the last example it made sense to name the `email` and `username` function parameters with the same names as the fields in the `struct`, but having to repeat them when assigning them to struct fields is a bit tedious. Luckily, there is a convenient shorthand for initializing struct fields from variables with the same names:

```rust
fn build_user_short(email: ByteArray, username: ByteArray) -> User {
    User { email, username, active: true, sign_in_count: 1, }
}
```

## Creating Instances from Other Instances with Struct Update Syntax

Use struct update syntax to create a new instance from an existing one, changing some of the fields while keeping the rest the same. This is achieved using the `..` operator:

Without update syntax:

```rust
let user2 = User {
    active: user1.active,
    username: user1.username,
    email: "another@example.com",
    sign_in_count: user1.sign_in_count,
};
```

With update syntax:

```rust
let user2 = User { email: "another@example.com", ..user1 };
```

The `..user1` syntax copies the remaining fields from `user1` to `user2`. Note that this moves the data from `user1` to `user2`, so `user1` cannot be used afterwards if it contains non-copiable types.

## Conclusion

Structs are a powerful way to group related data. They improve code clarity and provide flexibility in data management. By using field init shorthand and update syntax, you can write more concise and readable code.
