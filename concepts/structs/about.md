# Structs

Structs are similiar to tuples, in that both hold multiple related values. Like tuples, the pieces of a `struct` can be different types. Unlike with tuples, in a `struct` you’ll name each piece of data so it’s clear what the values mean.

## Defining and Instantiating Structs

You define a struct by using the `struct` keyword followed by the name of the `stuct`. Inside the curly braces, you define the fields of the `struct`, each with a name and a type.

The code snippet below shows an example of a defination for a `struct` named User.

```Rust
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}
```

In the example above, the User `struct` has four fields: `active`, `username`, `email`, and `sign_in_count`. The `active` field is a `boolean`, `username` and `email` are `ByteArray` types, and `sign_in_count` is a `u64`.

To create an instance of a `struct` after we have defined it, we use the `struct` name followed by curly braces containing the key-value pairs of the fields and their values. We don’t have to specify the fields in the same order in which we declared them in the struct. This means the `struct` defination is like a general template for the type, and instances fill in that template with particular data to create values of the type.

Below is an example of two instances of the `User` struct. Note that the fields are not in the same order as they were declared in the `struct` defination as this is not a requirement as stated earlier.

```Rust
let user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };

let user2 = User {
        sign_in_count: 1, username: "someusername123", active: true, email: "someone@example.com"
    };
```

## Interacting with Instance of a Struct

To access the fields of a `struct` instance, we use dot notation. We can also use the dot notation to change the value of a particular field in a mutable `struct` instance.

The code snippet below shows how to access and change the value of the fields of the `User` struct instances:

```Rust
let mut user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };
user1.email = "anotheremail@example.com";
```

In the example above, we first create a mutable instance of the `User` struct named `user1`. We then change the value of the `email` field. Note that Cairo doesn’t allow us to mark only certain fields as mutable.

As with any expression, we can construct a new instance of the struct as the last expression in the function body to implicitly return that new instance.

The code snippet below shows how to implicitly return a new instance of the `User` struct:

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

In the example above, the `build_user` function takes an `email` and `username` as arguments and returns a new instance of the `User` struct with the `email` and `username` fields set to the values of the arguments passed to the function. The `active` field is set to `true`, and the `sign_in_count` field is set to `1`.

It makes sense to name the function parameters with the same name as the fields in the struct. This is a common pattern that is useful for writing clear code, but having to repeat the email and username field names and variables is a bit tedious. Luckily, there is a convienent shorthand for initializing structs from variables with the same name.

The code snippet below shows how to use the shorthand:

```Rust
fn build_user_short(email: ByteArray, username: ByteArray) -> User {
    User { active: true, username, email, sign_in_count: 1, }
}
```

In the example above, we use the shorthand to initialize the `User` struct with the `email` and `username` fields set to the values of the arguments passed to the function. The `active` field is set to `true`, and the `sign_in_count` field is set to `1`.

## Creating Instances from Other Instances with Struct Update Syntax

It’s often useful to create a new instance of a `struct` that uses most of an old instance’s values but changes some. You can do this using struct update syntax. The syntax .. specifies that the remaining fields not explicitly set should have the same value as the fields in the given instance.

The code snippets below shows how to create a `User` struct instance without and with the struct update syntax:

```Rust
let user2 = User {
        active: user1.active,
        username: user1.username,
        email: "another@example.com",
        sign_in_count: user1.sign_in_count,
    };
```

```Rust
let user2 = User { email: "another@example.com", ..user1 };
```

The examples above shows a comparison of creating a new instance of the `User` struct named `user2` from the `user1` instance. The first example shows how to create a new instance without using the struct update syntax, while the second example shows how to create a new instance using the struct update syntax. The struct update syntax is more concise and easier to read.

In the second example, note that using the struct update syntax the `..user1` part must come last to specify that any remaining fields should get their values from the corresponding fields in user1, but we can choose to specify values for as many fields as we want in any order, regardless of the order of the fields in the struct’s definition.

Also note that the struct update syntax uses = like an assignment; this is because it moves the data. In this example, we can no longer use `user1` as a whole after creating `user2` because the `ByteArray` in the username field of `user1` was moved into `user2`. If we had given `user2` new `ByteArray` values for both `email` and `username`, and thus only used the `active` and `sign_in_count` values from `user1`, then `user1` would still be valid after creating `user2`. Both `active` and `sign_in_count` are types that implement the Copy trait.
