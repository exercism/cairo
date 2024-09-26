# Instructions

In the magical world of Echoes, there exists a powerful spell called "EchoSpeak". This spell allows wizards to communicate their thoughts and observations through spoken words, which are written out by magical quills. To master this spell, wizards must learn how to formulate their words and thoughts clearly and concisely, whether it's about numbers, objects, or complex magical constructs.

Your task as a Wizard's Apprentice is to master the art of EchoSpeak. This requires you to learn how to print various types of magical data to the enchanted scrolls. EchoSpeak works by taking a special magical ink, represented by the `ByteArray`, and inscribing formatted messages to the scroll using spells like `println!` and `print!`.

However, when dealing with custom magical constructs like enchanted items or spells, EchoSpeak needs a special incantation to understand how to represent these objects. That's where your magic comes in - learning to implement special spells known as `traits` for custom magical items.

## 1. Formatting Magical Words

Sometimes, wizards need to format their magical words before inscribing them on scrolls. You'll write a function that formats three magical words into a single message.

Implement a function called `format_magical_chant` that returns a formatted string in the form of "chant1-chant2-chant3".

Example:

```rust
let result = format_magical_chant("Spark", "Shine", "Glow");
assert_eq!(result, "Spark-Shine-Glow");
```

## 2. Echoing Custom Enchanted Items

The realm of Echoes is filled with enchanted items. One such item is the EchoStone, which contains two magical attributes: power and duration. Your task is to implement the `stringify_echo_stone` function that converts an EchoStone into a `ByteArray` in a special format `"EchoStone [power: x, duration: y]"` by implementing the `Display` trait.

Example:

```rust
let stone = EchoStone { power: 100, duration: 300 };
assert_eq!(stringify(stone), "EchoStone [power: 100, duration: 300]");
```

## 3. Debugging the Magic

As a wizard apprentice, debugging is essential for complex magical constructs. You will create a function that prints an `EchoStone` for debugging using the `Debug` trait. The format should be: `"Debugging EchoStone: { power: x, duration: y }"`.

Example:

```rust
let stone = EchoStone { power: 25, duration: 10 };
assert_eq!(format!("{:?}", stone), "Debugging EchoStone: { power: 25, duration: 10 }");
```
