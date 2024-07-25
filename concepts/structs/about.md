# Structs

Structs are custom data types that let you name and package together multiple related values. They are similar to tuples, but more flexible and lets you name each piece of data, making your code clearer.

## Defining and Instantiating Structs

To define a `struct`, use the `struct` keyword followed by a name and curly braces containing the fields with their names and types.

Example:

```Rust
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}
```

To create an instance of a `struct`, specify the `struct` name and use curly braces with key-value pairs for the fields. Note that you can list the fields in any order when creating an instance.

Example:

```Rust
let user1 = User {
   active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};

let user2 = User {
    sign_in_count: 1, username: "someusername123", active: true, email: "someone@example.com"
};
```

## Interacting with Instance of a Struct

Use dot notation to access or modify the fields of a `struct` instance. Note that to modify a field, the instance must be mutable.

Example:

```Rust
let mut user1 = User {
    active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
};
user1.email = "anotheremail@example.com";
```

As with any expression, we can construct a new instance of the `struct` as the last expression in the function body to implicitly return that new instance.

Example:

```Rust
fn build_user(email: ByteArray, username: ByteArray) -> User {
    User {
        email: email,
        username: username,
        active: true,
        sign_in_count: 1,
    }
}
```

### Field Init Shorthand

It makes sense to name the function parameters with the same name as the fields in the `struct`, but having to repeat the `email` and `username` in this example is a bit tedious. Luckily, there is a convienent shorthand for initializing structs from variables with the same name.

Example:

```Rust
fn build_user_short(email: ByteArray, username: ByteArray) -> User {
    User { active: true, username, email, sign_in_count: 1, }
}
```

## Creating Instances from Other Instances with Struct Update Syntax

Use `struct` update syntax to create a new instance from an existing one, changing some of the fields while keeping the rest the same.

Examples:

Without updated syntax:

```Rust
let user2 = User {
        active: user1.active,
        username: user1.username,
        email: "another@example.com",
        sign_in_count: user1.sign_in_count,
    };
```

With updated syntax:

The `..user1` syntax copies the remaining fields from `user1` to `user2`. Note that this moves the data from `user1` to `user2`, so `user1` cannot be used afterwards if it contains non-copy types.

```Rust
let user2 = User { email: "another@example.com", ..user1 };
```

## Conclusion

Structs are a powerful way to group related data. They improve code clarity and provide flexibility in data management. By using field init shorthand and update syntax, you can write more concise and readable code.
