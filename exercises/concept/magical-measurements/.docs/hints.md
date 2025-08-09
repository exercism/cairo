# Hints

## General

- [The Cairo Book - Type Conversions][tcb-conversions]
- [The Cairo Book - Custom Type Conversion][tcb-ctc]

## 1. Converting Signed to Unsigned

- Check if the signed value is negative - if so, return `Option::None`
- Check if the signed value exceeds `u16::MAX` (65535) - if so, return `Option::None`
- For valid values, cast using `.try_into()` or direct conversion
- Remember that `u16` can hold values from 0 to 65535

## 2. Converting Unsigned to Signed

- Since `u16::MAX` (65535) fits comfortably in `i32`, this conversion always succeeds
- Use `.into()` for safe conversion from `u16` to `i32`

## 3. Custom Type Conversion

- Implement the `Into` trait with the syntax: `impl IntoImplName of Into<SourceType, TargetType>`
- In the `into` method, create a new instance of the target type
- Map the `potency` field from `Essence` to the `strength` field in `Elixir`
- Once the trait is implemented, you can use `.into()` on `Essence` instances

## 4. Using the Into Trait

- After implementing the `Into` trait, call `.into()` on the `Essence` parameter
- The compiler will automatically use your trait implementation
- The return type annotation helps Cairo know which conversion to use

[tcb-conversions]: https://www.starknet.io/cairo-book/ch02-02-data-types.html#type-conversion
[tcb-ctc]: https://www.starknet.io/cairo-book/ch05-02-an-example-program-using-structs.html#conversions-of-custom-types
