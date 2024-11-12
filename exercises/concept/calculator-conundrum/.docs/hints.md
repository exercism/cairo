# Hints

## General

- [Unrecoverable Errors][unrecoverable]: invoke a panic with error message.
- [panic! Macro][panic-excl-macro]: invoke a panic with `ByteArray` error message.
- [assert! Macro][assert]: invoke a panic if a condition evaluates to `false`
- [Result Enum][result]: how to use the `Result` enum.

## 2. Handle illegal operations

- You need to [return an error][result] here.

## 3. Handle no operation provided

- You need to [panic][panic-excl-macro] here with a `ByteArray` message to handle empty strings for operations.

## 4. Handle errors when dividing by zero

- You need to panic here to handle division by zero.

[unrecoverable]: https://book.cairo-lang.org/ch09-01-unrecoverable-errors-with-panic.html#unrecoverable-errors-with-panic
[panic-excl-macro]: https://book.cairo-lang.org/ch09-01-unrecoverable-errors-with-panic.html#panic-macro
[assert]: https://book.cairo-lang.org/ch11-05-macros.html?highlight=assert#assert-and-assert_xx-macros
[result]: https://book.cairo-lang.org/ch09-02-recoverable-errors.html#the-result-enum