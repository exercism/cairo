# Integer Types

An `integer` is a number without a fractional component. In Cairo, the type declaration for integers indicates the number of bits the programmer can use to store the value.

Unsigned integers can only represent positive numbers and the number 0 (zero), which can be beneficial in certain programming contexts, such as array indexing and memory management.

Cairo also provides support for signed integers, starting with the prefix `i`. These integers can represent both positive and negative values, with sizes ranging from `i8` to `i128`. Each signed variant can store numbers from $-2^{n-1}$ to $2^{n-1} - 1$ inclusive, where $n$ is the number of bits that variant uses. For example, an `i8` can store numbers from $-2^7$ to $2^7 - 1$, which equals $-128$ to $127$.

| Length   | Unsigned | Signed   |
|----------|----------|----------|
| 8-bit    | u8       | i8       |
| 16-bit   | u16      | i16      |
| 32-bit   | u32      | i32      |
| 64-bit   | u64      | i64      |
| 128-bit  | u128     | i128     |
| 256-bit  | u256     | i256     |

There is also a special integer type called `usize`, which is currently just an alias for `u32`. This type might play a more distinct role in the future, once Cairo can be compiled to MLIR (Multi-Level Intermediate Representation).