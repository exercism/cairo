# Hints

- Remember that [`felt252` operations are performed modulo $P$][felts]. If your result exceeds the range, you should adjust it by adding or subtracting a multiple of $P$.

[felts]: https://book.cairo-lang.org/ch02-02-data-types.html#felt-type
