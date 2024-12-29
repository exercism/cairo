# Introduction

Type conversion in Cairo allows you to transform values between different types using the `Into` and `TryInto` traits.
The `Into` trait is used for guaranteed conversions, while `TryInto` handles fallible conversions that may fail if the value doesn't fit the target type.
These traits can also be implemented for custom types, enabling flexible and precise conversions in your programs.
