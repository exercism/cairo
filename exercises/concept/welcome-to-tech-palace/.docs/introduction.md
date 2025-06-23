# Introduction

Cairo doesn't have a native type for strings but provides two ways to handle them: short strings using simple quotes and `ByteArray` using double quotes.

A short string is an ASCII string where each character is encoded on one byte.

The type Cairo uses for short strings by default is `felt252`, making their maximum length only 31 characters.

```rust
// below are different ways to write the same value
let name: felt252 = 'Jane';     // short string format
let name: felt252 = 0x4a616e65; // byte format
let name: felt252 = 1247899237; // decimal format
```

Technically, any integer type smaller than `felt252` can be represented using the short string format.

```rust
// all of the below are equal u8 values, they are just written using different formats!
let lowercase_a_in_ascii: u8 = 'a';  // short string format
let lowercase_a_in_ascii: u8 = 0x61; // byte format
let lowercase_a_in_ascii: u8 = 97;   // decimal format
```

For strings longer than 31 characters Cairo provides `ByteArray`, which has an unlimited length.

```rust
let long_string: ByteArray = "this is a string which has more than 31 characters";
```

ByteArrays can be concatenated via the `+` operator:

```rust
"Jane" + " " + "Austen"
// => "Jane Austen"
```

Some special characters need to be escaped with a leading backslash, such as `\t` for a tab and `\n` for a new line in strings.

```rust
"How is the weather today?\nIt's sunny"  
// =>
// How is the weather today?
// It's sunny
```

You can even access individual bytes within a ByteArray using its index.

Be careful though, the type of the returned byte is `u8` and not `ByteArray`!

```rust
let hello: ByteArray = "Hello World!";
let exclamation_mark: u8 = hello[11];
// => 33
```

The core library provides many useful methods and operators to work on ByteArrays.

For more information about ByteArray methods, check out the [ByteArrayTrait documentation][docs].

Here are some examples:

```rust
let name: felt252 = 'Jane';
let mut greeting: ByteArray = "Welcome ";

// append_word appends a single word of a given number of bytes to the end of the ByteArray 
greeting.append_word(name, 4);
// => "Welcome Jane"

// rev returns a ByteArray with the all characters reversed
let rev_greeting = greeting.rev();
// => "enaJ emocleW"
```

[docs]: https://docs.swmansion.com/scarb/corelib/core-byte_array-ByteArrayTrait.html
