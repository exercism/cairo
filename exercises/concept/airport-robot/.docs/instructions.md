# Instructions

The new airport in Berlin hired you as a developer for their robots lab.
They have clunky, somewhat humanoid-looking robots that they are trying to use to improve customer service.

Your first task on the job is to program the robot to greet people in their native language after they scanned their passports at the self-check-in counter.

The robot is proud of its abilities so it will always say which language it can speak first and then greet the person.
For example, if someone scans a German passport the robot would say:

```txt
I can speak German: Hallo Dietrich!
```

## 1. Create the abstract greeting functionality

You will not write the code for the different languages yourself.
You need to structure your code so other developers can easily add languages.

As a first step, define a trait `Greeter` with two functions.

- `language_name` which returns the language (a `ByteArray`) that the robot will use to greet the visitor.
- `greet` which accepts a visitor's name (a `ByteArray`) and returns the greeting message in a specific language (a `ByteArray`).

Next, implement a function `say_hello` that accepts the name of the visitor and something that implements the `Greeter` trait and returns the desired greeting (a `ByteArray`).
For example, imagine a German `Greeter` implementation for which `language_name` returns `"German"` and `greet` returns `"Hallo {name}!"`:

```rust
say_hello("Dietrich", germanGreeter)
// => "I can speak German: Hallo Dietrich!"
```

## 2. Implement Italian

Now make the robot work for people that scan Italian passports.

Create a struct `Italian` and implement the two functions to fulfill the `Greeter` trait from task 1.
You can greet someone in Italian with `"Ciao {name}!"`.

## 3. Implement French

Before you call it a day, you are supposed to add functionality to greet people in French.

Create a struct `French` and implement the two functions to fulfill the `Greeter` trait.
You can greet someone in French with `"Bonjour {name}!"`.
