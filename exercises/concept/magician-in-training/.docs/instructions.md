# Instructions

As a magician-to-be, Elyse needs to practice some basics.

She has a stack of cards that she wants to manipulate.

To make things a bit easier she only uses the cards 1 to 10.

The stack of cards is represented by an `Array`, with the bottom of the stack at the front of the array, and the top of the stack at the back.

## 1. Insert a card at the of top the stack

Implement the function `insert_top` that returns a copy of the stack with the new card provided added to the top of the stack.

```rust
let stack = array![5, 9, 7, 1];
insert_top(stack, 8);
// -> [5, 9, 7, 1, 8]
```

## 2. Remove the top card from the stack

Implement the function `remove_top_card` that returns a copy of the stack having had its top card removed.

If the given stack is empty, the original stack should be returned, unchanged.

```rust
let stack = array![3, 2, 6, 4, 8];
remove_top_card(stack);
// -> [3, 2, 6, 4]
```

## 3. Insert a card at the bottom of the stack

Implement the function `insert_bottom` that returns a copy of the stack with the new card provided added to the bottom of the stack.

```rust
let stack = array![5, 9, 7, 1];
insert_bottom(stack, 8);
// -> [8, 5, 9, 7, 1]
```

## 4. Remove a card from the bottom of the stack

Implement the function `remove_bottom_card` that returns a copy of the stack having had its bottom card removed.

If the given stack is empty, the original stack should be returned, unchanged.

```rust
let stack = array![8, 5, 9, 7, 1];
remove_bottom_card(stack);
// -> [5, 9, 7, 1]
```

## 5. Check size of the stack

Implement the function `check_size_of_stack` that checks whether the size of the stack is equal to a given `stack_size` or not.

```rust
let stack = array![3, 2, 6, 4, 8];
check_size_of_stack(stack, 4);
// -> false
```
