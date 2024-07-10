# String Types

## String Type

Cairo do not have a native data type for strings. However, there are two ways to form a string type: short strings and ByteArray.

### Short strings

A short string is formed with a single quote where each character that makes up the string is encoded on one byte - [see ASCII table](https://www.asciitable.com/).

As a ASCII string, for instance, 'abc' will be:

- 'a' results to 0x61
- 'b' results to 0x62
- 'c' results to 0x63
- 'abc' results to 0x616263

The felt252 data type can hold short strings type in Cairo. A felt252 short string is limited to 31 characters due to the size of felt252 being 251 bits.

Examples of short strings declarations:

```rust
       let my_first_char = 'D';
       let my_first_char_in_hex = 0x44;

       let my_first_string = 'Hello world';
       let my_first_string_in_hex = 0x48656C6C6F20776F726C64;
```

### ByteArray

The ByteArray struct was introduced in Cairo 2.4.0. The ByteArray strings are written in double quotes as follows:

```Rust
    let long_string: ByteArray = "this is a string which has more than 31 characters";
```

Technically, the update also introduced the `bytes31` which holds 31 bytes and which fits into a felt. The ByteArray struct is made of an array of 31 byte, a single felt and length for the remainder.

```Rust
#[derive(Drop, Clone, PartialEq, Serde, Default)]
struct ByteArray {
    data: Array<bytes31>,
    pending_word: felt252,
    pending_word_len: usize,
}
```
