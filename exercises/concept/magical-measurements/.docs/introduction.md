# Introduction

Type conversions in Cairo allow you to transform data from one type to another, enabling flexible and safe data manipulation.

## Basics

Cairo provides several mechanisms for type conversion:

### Direct Casting

For compatible numeric types, you can use direct casting:

```rust
let small_number: u8 = 42;
let big_number: u32 = small_number.into();
```

### The Into Trait

The `Into` trait enables conversion from one type to another:

```rust
let value: u16 = 100;
let converted: u32 = value.into();
```

### The TryInto Trait

For conversions that might fail, use `TryInto` which returns an `Option`:

```rust
let large_value: u32 = 70000;
let small_value: Option<u16> = large_value.try_into();

match small_value {
    Option::Some(v) => println!("Converted: {}", v),
    Option::None => println!("Conversion failed"),
}
```

## Custom Type Conversions

You can implement `Into` for your own types:

```rust
#[derive(Drop)]
struct Celsius {
    value: i32,
}

#[derive(Drop)]
struct Fahrenheit {
    value: i32,
}

impl CelsiusIntoFahrenheit of Into<Celsius, Fahrenheit> {
    fn into(self: Celsius) -> Fahrenheit {
        Fahrenheit { value: (self.value * 9) / 5 + 32 }
    }
}
```

## Safety Considerations

- Use `TryInto` when conversion might fail (e.g., large to small types)
- Use `Into` when conversion always succeeds
- Always handle `Option::None` cases from `TryInto`
- Consider overflow and underflow when converting between signed and unsigned types
