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

Below is an example of two instances of the `User` struct. Note that the fields are not in the same order as they were declared in the `struct` defination:

```Rust
let user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };

let user2 = User {
        sign_in_count: 1, username: "someusername123", active: true, email: "someone@example.com"
    };
```

## Interacting with Structs Instance

To access the fields of a `struct` instance, we use dot notation. We can also use the dot notation to change the value of a particular field in a mutable `struct` instance.

The code snippet below shows how to access and change the value of the fields of the `User` struct instances:

```Rust
let mut user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };
user1.email = "anotheremail@example.com";
```

In the example above, we first create a mutable instance of the `User` struct named `user1`. We then change the value of the `email` field. Note that Cairo doesn’t allow us to mark only certain fields as mutable.
