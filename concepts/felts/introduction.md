# Introduction

Felt is one of the scalar types in Cairo, just like integers and booleans. `felt252` is a fundamental data type in Cairo from which all other data types are derived. `felt252` can also be used to store [short string representations](https://starknet-by-example.voyager.online/getting-started/basics/bytearrays-strings.html#short-strings) with a maximum length of 31 characters.

For example:

```rust
    let felt: felt252 = 100;
    let felt_as_str = 'Hello Starknet!';

    let _felt = felt + felt_as_str;
```
