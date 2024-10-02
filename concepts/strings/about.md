# String Types

Cairo does not have a native data type for strings.
However, there are two ways to represent a string type: short strings using a single `felt252` and arbitrary length strings using `ByteArray`.

## Short strings

A short string is formed with single quotes where each character that makes up the string is encoded on one byte following the [ASCII standard](https://www.asciitable.com/).

As an ASCII string, for instance, `'abc'` will be:

- `'a'` is equivalent to `0x61`
- `'b'` is equivalent to `0x62`
- `'c'` is equivalent to `0x63`
- `'abc'` is equivalent to `0x616263`

The `felt252` data type holds short strings type in Cairo.
As `felt252` contains 251 bits, a short string is limited to 31 characters (31 \* 8 = 248 bits, which is the maximum multiple of 8 that fits in 251 bits).

Examples of short string declarations:

```rust
    let my_first_char = 'D';
    let my_first_char_in_hex = 0x44;

    let my_first_string = 'Hello world';
    let my_first_string_in_hex = 0x48656C6C6F20776F726C64;
```

### ByteArray

The ByteArray struct was introduced in Cairo 2.4.0.
The ByteArray strings are written in double quotes as follows:

```rust
    let long_string: ByteArray = "this is a string which has more than 31 characters";
```

Technically, the update also introduced the `bytes31` type which holds 31 bytes and which fits into a felt.
The `ByteArray` struct basically represents long string using an array of `bytes31` that hold the "whole words" (i.e. words that fill the whole felt) and a single felt field that holds an "incomplete word" (the number of bytes within are specified in separate length field).

```rust
#[derive(Drop, Clone, PartialEq, Serde, Default)]
struct ByteArray {
    data: Array<bytes31>,
    pending_word: felt252,
    pending_word_len: usize,
}
```
