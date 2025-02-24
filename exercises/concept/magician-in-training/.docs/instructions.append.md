# Instructions append

To understand why working with arrays in Cairo is not as straightforward as in other programming languages, it is helpful to bear in mind that Cairo uses an immutable memory model, meaning that once a memory cell is written to, it can't ever be overwritten, only read from.

The language abstracts away this feature somewhat, allowing developers to declare and use their variables as if they were mutable.

Although this makes writing code a bit more challenging, especially code that makes use of the `Array` type (including `ByteArray`, which underneath is an "array of bytes"), it enables writing _provable_ programs which can be confidently executed even on untrusted machines, making the trade-off more than worth it.
