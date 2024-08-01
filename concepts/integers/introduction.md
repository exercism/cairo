# Introduction

`Integer` is one of the scalar types in Cairo, just like felt252 and booleans. The `felt252` type is a fundamental type in the core library, serving as the foundation for creating all other types in the core library. 

However, for added safety, it's best to use integer types instead of `felt252` whenever you can. Integer types have built-in security features that help protect your code from common issues like overflow and underflow errors. Using these safer integer types makes your programs more secure and less vulnerable to attacks or other security risks.

Integers are whole numbers with no decimal separator.

Integer types can either store only positive numbers (unsigned) or store either positive and negative numbers (signed).

Examples are -6, 0, 1, 25 and 976.

Note that you can use underscores to improve the readability of longer numbers: `1_000_000`.
