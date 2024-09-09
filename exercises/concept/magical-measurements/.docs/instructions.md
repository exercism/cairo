# Instructions

Astrid, an adventurous alchemist, is trying to standardize the magical units of measurement she collects from different realms. Some realms use signed measurements (which can be negative), while others use unsigned ones (which are always positive). On top of that, Astrid has two custom types for certain rare ingredients, and she needs a way to easily convert between these types.

Your mission is to help Astrid convert between signed and unsigned integers, and create custom type conversions for her special ingredient types using Cairo’s `Into` and `TryInto` traits.

## 1: Converting Magical Units Between Signed and Unsigned

Astrid has measurements that sometimes come in positive or negative values (signed integers), but for certain tasks, she needs to ensure the values are always positive (unsigned integers).

Help Astrid by writing a function that converts:

1. A signed integer (`i32`) to an unsigned integer (`u16`).
2. An unsigned integer (`u16`) to a signed integer (`i32`).

```rust
let signed_value: i32 = -42;
match convert_signed_to_unsigned(signed_value) {
    Option::Some(v) => println!("Converted to unsigned: {}", v),
    Option::None => println!("Failed to convert: {}", signed_value),
} // prints "Failed to convert: -42"

let unsigned_value: u16 = 42;
let signed_value: i32 = convert_unsigned_to_signed(unsigned_value);
println!("Converted to signed: {}", signed_value); // prints "Converted to signed: 42"
```

## 2: Custom Ingredient Types Conversion

Astrid works with two rare ingredients, **Essence** and **Elixir**, which are represented by custom types. She wants to be able to convert **Essence** to **Elixir**, but not the other way around.

Help Astrid by creating two custom types, `Essence` and `Elixir`, and implementing the `Into` trait to convert from `Essence` to `Elixir`.

Write a function that accepts an `Essence` and converts it into an `Elixir` using `.into()`.

```rust
#[derive(Drop)]
struct Essence {
    potency: u16,
}

#[derive(Drop)]
struct Elixir {
    strength: u16,
}

fn convert_essence_to_elixir(essence: Essence) -> Elixir {
    // Convert the Essence to Elixir using the Into trait.
    essence.into()
}

fn main() {
    let essence = Essence { potency: 100 };
    let elixir: Elixir = convert_essence_to_elixir(essence);
    println!("Elixir strength: {}", elixir.strength); // Elixir strength: 100
}
```
