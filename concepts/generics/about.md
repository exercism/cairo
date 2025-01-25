# Generic Data Types

Generics in Cairo let you write reusable code that works with various types, avoiding duplication and enhancing maintainability.

You can use generics with functions, structs, enums, traits, and methods.

## Generic Functions

A generic function operates on different types without needing separate implementations.

For example:

```rust
fn largest_list<T>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}
```

Here, `T` is a placeholder for any type.

However, Cairo requires trait bounds to ensure the generic type meets specific requirements.

If `T` needs to be droppable, we can update the signature:

```rust
fn largest_list<T, impl TDrop: Drop<T>>(l1: Array<T>, l2: Array<T>) -> Array<T> {
    if l1.len() > l2.len() {
        l1
    } else {
        l2
    }
}
```

Trait bounds, like `Drop` or `PartialOrd`, add constraints to generics for specific operations.

## Anonymous Constraints

If a trait implementation isn’t directly used in a function, you can write anonymous constraints using `+`:

```rust
fn smallest_element<T, +PartialOrd<T>, +Drop<T>, +Copy<T>>(list: @Array<T>) -> T {
    let mut smallest = *list[0];
    let mut index = 1;

    while index < list.len() {
        if *list[index] < smallest {
            smallest = *list[index];
        }
        index += 1;
    };

    smallest
}
```

This avoids naming traits like `TPartialOrd`, reducing verbosity.

## Structs with Generics

Generics in structs allow fields to be flexible.

For example:

```rust
#[derive(Drop)]
struct Wallet<T> {
    balance: T,
}

let w = Wallet { balance: 42 };
```

If a struct needs multiple generic types, just add more placeholders:

```rust
#[derive(Drop)]
struct Wallet<T, U> {
    balance: T,
    address: U,
}

let w = Wallet { balance: 42, address: '0xabc' };
```

## Enums with Generics

Enums can hold generic data types too.

For example:

```rust
enum Option<T> {
    Some: T,
    None,
}
```

The `Option<T>` enum can represent an optional value of any type.

Similarly, `Result<T, E>` allows defining success and failure types:

```rust
enum Result<T, E> {
    Ok: T,
    Err: E,
}
```

## Generic Methods

Methods can also use generics.

For example:

```rust
#[derive(Copy, Drop)]
struct Wallet<T> {
    balance: T,
}

trait WalletTrait<T> {
    fn balance(self: @Wallet<T>) -> T;
}

impl WalletImpl<T, +Copy<T>> of WalletTrait<T> {
    fn balance(self: @Wallet<T>) -> T {
        *self.balance
    }
}

let w = Wallet { balance: 50 };
assert!(w.balance() == 50);
```

You can also define methods for specific generic types, such as `Wallet<u128>`:

```rust
trait WalletReceiveTrait {
    fn receive(ref self: Wallet<u128>, value: u128);
}

impl WalletReceiveImpl of WalletReceiveTrait {
    fn receive(ref self: Wallet<u128>, value: u128) {
        self.balance += value;
    }
}

let mut w = Wallet { balance: 50 };
w.receive(100);
assert!(w.balance() == 150);
```

## Mixing Generic Types

Generics can handle complex combinations.

For instance, combining two `Wallet` instances of different types:

```rust
trait WalletMixTrait<T1, U1> {
    fn mixup<T2, +Drop<T2>, U2, +Drop<U2>>(
        self: Wallet<T1, U1>, other: Wallet<T2, U2>,
    ) -> Wallet<T1, U2>;
}

impl WalletMixImpl<T1, +Drop<T1>, U1, +Drop<U1>> of WalletMixTrait<T1, U1> {
    fn mixup<T2, +Drop<T2>, U2, +Drop<U2>>(
        self: Wallet<T1, U1>, other: Wallet<T2, U2>,
    ) -> Wallet<T1, U2> {
        Wallet { balance: self.balance, address: other.address }
    }
}

let w1 = Wallet { balance: true, address: 10 };
let w2 = Wallet { balance: 32, address: 100 };
let w3 = w1.mixup(w2);

assert!(w3.balance);
assert!(w3.address == 100);
```

By adding `+Drop` constraints, the compiler ensures proper handling of resources.

Generics are powerful but require careful management of constraints.

Use them to write reusable, type-agnostic, and concise code.
