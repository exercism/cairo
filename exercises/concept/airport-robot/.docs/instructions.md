# Instructions

The new airport in Berlin hired developers for their robots lab and you are starting your job there.
They have clunky, somewhat humanoid-looking robots that they are trying to use to improve customer service.

Your first task on the job is to write a program so that the robot can greet people in their native language after they scanned their passports at the self-check-in counter.

The robot is proud of its abilities so it will always say which language it can speak first and then greet the person.
For example, if someone scans a German passport the robot would say:

```txt
I can speak German: Hallo Dietrich!
```

## 1. Create the abstract greeting functionality

You will not write the code for the different languages yourself so you need to structure your code for the robot so that other developers can easily add more languages later.

As a first step, define a trait `Greeter` with two functions.

- `language_name` which returns the name of the language (a `ByteArray`) that the robot is supposed to greet the visitor in.
- `greet` which accepts a visitor's name (a `ByteArray`) and returns a `ByteArray` with the greeting message in a specific language.

Next, implement a function `say_hello` that accepts the name of the visitor and anything that implements the `Greeter` trait as arguments and returns the desired greeting `ByteArray`.
For example, imagine a German `Greeter` implementation for which `language_name` returns `"German"` and `greet` returns `"Hallo {name}!"`:

```rust
say_hello("Dietrich", germanGreeter)
// => "I can speak German: Hallo Dietrich!"
```

## 2. Implement Italian

Now your job is to make the robot work for people that scan Italian passports.

For that, create a struct `Italian` and implement the two functions that are needed for the struct to fulfill the `Greeter` trait you set up in task 1.
You can greet someone in Italian with `"Ciao {name}!"`.

## 3. Implement French

Before you call it a day, you are also supposed to finish the functionality to greet people in French.

For that, create a struct `French` and implement the two functions that are needed for the struct to fulfill the `Greeter` trait here as well.
You can greet someone in French with `"Bonjour {name}!"`.
