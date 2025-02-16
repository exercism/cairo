# Hints

## General

- The [ByteArray][bytearray] type contains a few useful inbuilt methods, you'll generally have to implement your own utility functions for manipulating ByteArrays.
- `ByteArray` actually represents an array of bytes and not "chars" as in many other languages.
- Working with both short and longs strings at the same time can be challenging, so some helper functions are already implemented which you can use for this exercise.

## 1. Create the welcome message

- Strings can be concatenated using the `+` operator.
- Check if you can use any of the helper functions.

## 2. Add a fancy border

- You can append `'*'` characters in a loop.
- A newline is a special escape character.

## 3. Clean up old marketing messages

- Find the start and end indices of the clean message.
- You will probably need to copy the clean message characters into a new ByteArray one by one.

[bytearray]: https://docs.swmansion.com/scarb/corelib/core-byte_array-ByteArrayTrait.html
