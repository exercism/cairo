# Instructions

You are working on a game targeting a low-power embedded system and need to
write several convenience traits which will be used by other parts of the game.

## 1. Calculate the quotient and remainder of a division

A quotient is the output of a division.

```rust
fn divmod(self: @u16, divisor: u16) -> (u16, u16)
```

Example:

```rust
let dividend: u16 = 10;
assert_eq!(dividend.divmod(3), (3, 1));
```

## 2. Choose even-positioned items from an array

This will be helpful to enable a screen-buffer optimization, your boss
promises.

```rust
trait EvensTrait<T> {
    fn evens(self: @Array<T>) -> Array<T>;
}
```

Examples:

```rust
let arr: Array<u16> = array![0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
assert_eq!(arr.evens(), array![0, 2, 4, 6, 8]);
```

```rust
let arr: Array<u16> = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
assert_eq!(arr.evens(), array![1, 3, 5, 7, 9]);
```

## 3. Calculate the manhattan distance of a position from the origin

For mapping convenience, you have a tuple type `Position`:

```rust
type Position = (i16, i16);
```

You need to implement a method `manhattan` on `Position` which returns the
[manhattan distance][taxicab-geometry] of that position from the origin (`let p: Position = (0, 0)`).

```rust
trait PositionTrait {
    fn manhattan(self: @Position) -> i16
}
```

Example:

```rust
let p: Position = (3, 4);
assert_eq!(p.manhattan(), 7);
```

[taxicab-geometry]: https://en.wikipedia.org/wiki/Taxicab_geometry
