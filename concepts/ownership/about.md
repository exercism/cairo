# Ownership
In Cairo, the concept of ownership is attached to variables rather than the values they hold.
This means that while multiple variables can refer to the same value, ownership is concerned with the variables themselves.
Values in Cairo are immutable, meaning once a value is created, it cannot be changed.
This immutability ensures that even if many variables refer to the same value, the value itself remains constant and unaltered.

 ## The ownership rules.
  _make sure to keep these rules in mind as you work with Cairo_
```
- Each variable in Cairo has an owner.
- There can only be one owner at a time.
- When the owner goes out of scope, the variable is destroyed.
```
### Variable scope
Technically a scope is the range within a program in which a variable is valid

```rust
fn main(){
     let x = 3;
}
   
```
the `x` is an integer which is valid at the point in which it is declared up to the end of the given scope, in this case `main()` function.

```rust
fn main(){ 
                      //x is not valid here; it has not been declared
     let x = 3;       //x is valid from this point forward ; it is been declared
// do stuffs with x   // x is also valid here; it is still in scope

} // this scope ended here and x goes out of scope and no longer valid.
   
```
Note: 
 - When `x` comes into scope, it is valid.
 - It remains valid until it goes out of scope.


 ### Moving Vaues
A move occurs when a value is passed to another function, rendering the original variable that referred to the value useless. This happens because moving a value causes the original variable to be destroyed, making it unusable.

complex data types are the types of data that is moved when passed into a function and array serves as a good example;
let's take a look at it;
```rust
fn get_len(arr: Array<u128>) -> u32{
    arr.len()
}
fn foo(arr: Array<u128>) {
    arr.pop_front();
}

fn main(){
    let mut new_arr: Array<u128> = array![1,2,3,4,5,6,7,8]; // declaration of array
    let len = get_len(new_arr);  //  new_arr value is moved here, rendering the variable useless going forward.
    foo(new_arr); // this will result in bug since new_arr is no longer valid
    let new_len = new_arr.len(); // this also not valid logic, new_arr has been moved out of this scope.
}

```
the above code won't compile because the `new_arr` variable is moved when passed to `get_len()`, rendering `new_arr` unusable afterwards. Subsequent references to `new_arr` result in a compilation error since the original variable is no longer valid after move occur.

### Snapshot
<!-- To be able to use a variable more than once without having to move t -->

When you pass a variable to a function, its ownership is usually transferred, making the original variable unusable. 

Snapshots provide an immutable view of a value at a certain point in time, allowing you to retain ownership of a variable while accessing its state.
A snapshot is a view of a value that cannot be modified. Any modification creates a new memory cell, leaving the snapshot's view unchanged.

```rust
fn get_len(arr: @Array<u128>) -> u32{ //changing the parameter to take in a snapshot rather than the ownership
    arr.len()
}
fn foo(arr: Array<u128>) {
    arr.pop_front();
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8]; //Declaration of array
    let snapshot = @new_arr; // Use `@` to create a snapshot of a variable
    let len = get_len(snapshot);
    foo(new_arr); // `new_arr` is still valid up until here and no further
    
    // let new_len = new_arr.len(); // This will throw an error when you uncomment the code because `new_arr` has been moved in the logic above
}


```
<figure> Using snapshots in Cairo allows you to maintain ownership of variables while safely accessing their state at specific points in time, ensuring data integrity and preventing accidental modifications.</figure>

### Desnap Operator:

 - Convert a snapshot back to a regular variable with `*`.



### Mutable References
Mutable references allow you to pass mutable values to a function and have them implicitly returned, maintaining ownership in the calling context. This can be achieved using the `ref` modifier, provided the variable is declared as mutable with `mut`.

```rust
fn get_len(arr: @Array<u128>) -> u32{ //changing the parameter to take in a snapshot rather than the ownership
    arr.len()
}
fn foo(ref arr: Array<u128>) { //use the ref modifier in accepting argument

    arr.pop_front();
}

fn main() {
    let mut new_arr: Array<u128> = array![1, 2, 3, 4, 5, 6, 7, 8]; //Declaration of array
    let snapshot = @new_arr; // Use `@` to create a snapshot of a variable
    let len = get_len(snapshot);
    foo(ref new_arr);  // Use `ref` to pass a mutable reference to a function.
    
    let new_len = new_arr.len(); 
}
```
<figure> By using mutable references, you can modify values within functions while retaining ownership in the original scope. </figure>
