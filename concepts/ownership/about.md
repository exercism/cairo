# Ownership
In Cairo, the concept of ownership is attached to _variables_ rather than the _values_ they hold.

This immutability ensures that even if many variables refer to the same value, the value itself remains constant and unaltered. Variables however can be mutable, so the compiler must ensure their correct usage by the programmer. This is the meaning of variable _ownership_: the owner is the code that can read (and write if mutable) the variable.

## Variable Ownership Rules.
```
1. Each variable in Cairo has an owner.
2. There can only be one owner at a time.
3. When the owner goes out of scope, the variable is destroyed.
```

## Variable Scope
A scope is the range within a program in which a variable is valid. Let's look at the following example that declares a variable `x` of type unsigned integer, with comments annotating where the variable is be valid:

```rust
fn main() { 
                      // x is not valid here, it has not been declared yet
     let x:u32 = 3;   // x is declared, it is valid from this point forward
  // do stuffs with x   

} // this scope ended here, `x` goes out of scope and is no longer valid
   
```
Note: 
 - When `x` comes into scope, it is valid.
 - It remains valid until it goes out of scope, in this case until the end of the `main()` function.

## Moving Values
A move occurs when a value is passed to another function, destroying the original variable that referred to the value (thus making the variable useless), and creating a new variable to hold the same value.

Arrays are an example of a complex type that is moved when passing it to another function. Here is a short reminder of what an array looks like:
let's take a look at it;
```rust
 let mut arr: Array<u128> = array![]; //arr is  been declared 
    arr.append(1);  // add values to arr
    arr.append(2); // add values to arr
```
How does the type system ensure that the Cairo program never tries to write to the same memory cell twice? Consider the following code, where we try to remove the front of the array twice:
```rust
fn foo(mut arr: Array<u128>) {
    arr.pop_front();  //pops out the frirst element in `arr` 
}

fn main() {
    let mut arr: Array<u128> = array![]; //arr is  been declared 
    foo(arr);        //
    foo(arr);
}
```
In this case, we try to pass the same value (the array in the `arr` variable) to both function calls. This means our code tries to remove the first element twice, which would try to write to the same memory cell twice - which is forbidden by the Cairo VM, leading to a runtime error. Thankfully, this code does not actually compile. Once we have passed the array to the `foo` function, the variable `arr` is no longer usable. We get this compile-time error, telling us that we would need Array to implement the Copy Trait:

## The Copy Trait
If a type implements the Copy trait, passing it to a function doesn't move the value but creates a new variable referring to the same value. This is a free operation because variables are a Cairo abstraction and values are always immutable.

To implement the Copy trait on your type, add the `#[derive(Copy)]` annotation to the type definition. However, Cairo won't allow this if the type or any of its components doesn't implement the Copy trait.
```rust
#[derive(Copy, Drop)]
struct Point {
    x: u128,
    y: u128,
}

fn main() {
    let p1 = Point { x: 5, y: 10 };
    foo(p1);
    foo(p1);
}

fn foo(p: Point) { // do something with p
}
```
In this example, we can pass `p1` twice to the `foo` function because the Point type implements the `Copy` trait. This means that when we pass `p1` to `foo`, we are actually passing a copy of `p1`, so `p1` remains valid. In ownership terms, this means that the ownership of `p1` remains with the `main` function. If you remove the `Copy` trait derivation from the `Point` type, you will get a compile-time error when trying to compile the code.

## Destroying Values
Linear types can also be utilized by being destroyed, which ensures that the associated resource is correctly released. In Cairo, one type that exhibits this behavior is Felt252Dict. For the sake of provability, these dictionaries must be 'squashed' when they are destructed. This step is crucial but can be easily overlooked. Therefore, to ensure that this important step is not missed, the type system and the compiler enforce the squashing of dictionaries when they are destroyed with the `Destruct` trait.
```rust
#[derive(Destruct)]
struct A {
    dict: Felt252Dict<u128>
}

fn main() {
    A { dict: Default::default() }; // No error here
}
```
when A goes out of scope, its dictionary will be automatically squashed, and the program will compile.
without the `Destruct` trait, the code won't compile. because dictionaries won't be able to squashed.

## Return Values and Scope
Returning values is equivalent to moving them. the example below shows an example of a function that returns some value.

``` rust
#[derive(Drop)]
struct A {}

fn main() {
    let a1 = gives_ownership();           // gives_ownership moves its return
                                          // value into a1

    let a2 = A {};                        // a2 comes into scope

    let a3 = takes_and_gives_back(a2);    // a2 is moved into
                                          // takes_and_gives_back, which also
                                          // moves its return value into a3

} // Here, a3 goes out of scope and is dropped. a2 was moved, so nothing
  // happens. a1 goes out of scope and is dropped.

fn gives_ownership() -> A {               // gives_ownership will move its
                                          // return value into the function
                                          // that calls it

    let some_a = A {};                    // some_a comes into scope

    some_a                                // some_a is returned and
                                          // moves ownership to the calling
                                          // function
}

// This function takes an instance some_a of A and returns it
fn takes_and_gives_back(some_a: A) -> A { // some_a comes into scope

    some_a                                // some_a is returned and 
                                          // moves ownership to the calling
                                          // function
}
```
While this works, moving into and out of every function is a bit tedious. What if we want to let a function use a value but not move the value? It’s quite annoying that anything we pass in also needs to be passed back if we want to use it again, in addition to any data resulting from the body of the function that we might want to return as well.

Cairo does let us return multiple values using a tuple, as shown in below

```rust
fn main() {
    let arr1: Array<u128> = array![];

    let (arr2, len) = calculate_length(arr1);
}

fn calculate_length(arr: Array<u128>) -> (Array<u128>, usize) {
    let length = arr.len(); // len() returns the length of an array

    (arr, length)
}
```
But this is too much ceremony and a lot of work for a concept that should be common. Luckily for us, Cairo has two features for passing a value without destroying or moving it, called references and snapshots.