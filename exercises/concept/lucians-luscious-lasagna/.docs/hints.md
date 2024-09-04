# Hints

## General

- An [integer value][integers] can be defined as one or more consecutive digits.
- If you see a `panic` error when running the tests, this is because you have not implemented one of the functions (it should say which one) or you have left the boilerplate in place. You need to remove the `panic!(...)` line from the supplied code and replace it with a real implementation.

## 1. Define the expected oven time in minutes

- You need to define a [function][functions] without any parameters.
- You need to [return][return] the expected oven time in minutes from the function.

## 2. Calculate the remaining oven time in minutes

- You need to define a [function][functions] with a single parameter.
- The function's parameter is an [integer][integers].
- You have to [explicitly return an integer][return] from a function.
- You can [call][functions] one of the other functions you've defined previously.
- You can use the [mathematical operator for subtraction][operators] to subtract values.

## 3. Calculate the preparation time in minutes

- You need to define a [function][functions] with a single parameter.
- The function's parameter is an [integer][integers].
- You have to [explicitly return an integer][return] from a function.
- You can use the [mathematical operator for multiplication][operators] to multiply values.

## 4. Calculate the elapsed working time in minutes

- You need to define a [function][functions] with two parameters.
- The function's parameter is an [integer][integers].
- You have to [explicitly return an integer][return] from a function.
- You can [call][functions] one of the other functions you've defined previously.
- You can use the [mathematical operator for addition][operators] to add values.

[functions]: https://book.cairo-lang.org/ch02-03-functions.html
[return]: https://book.cairo-lang.org/ch02-03-functions.html#functions-with-return-values
[operators]: https://book.cairo-lang.org/appendix-02-operators-and-symbols.html
[integers]: https://book.cairo-lang.org/ch02-02-data-types.html#integer-types
