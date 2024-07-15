# Tests

## Writing the Code

Write your code in `src/lib.cairo`.
The exercises come with a stub file in `src/lib.cairo` that will show you the signatures of the code you'll need to write.

For most exercises, it is best to write all your code in the file `src/lib.cairo`.
If you would like to split your solution into several files, consult The Cairo Book's [chapter on modules][chapter-modules].

[chapter-modules]: https://book.cairo-lang.org/ch07-02-defining-modules-to-control-scope.html

## Running Tests

To run the tests, first you need to change your working directory to the directory of the exercise you want to test:
```bash
cd path/to/exercise
```

And then run the following command:

```bash
$ scarb cairo-test
```

Only the first test is enabled by default.
After you are ready to pass the next test, remove the ignore flag from the next test (`#[ignore]`).
You can also remove the flag from all the tests at once if you prefer.

Feel free to write as little code as possible to get the tests to pass.
The test failures will guide you to what should be written next.

Because Cairo checks all code at compile time, you may find that your tests won't compile until you write the required code.
Even `ignore`d tests are checked at compile time.
You can [comment out][comments] tests that won't compile by starting each line with a `//`.
Then, when you're ready to work on that test, you can un-comment it.
Cairo also has a special macro called `panic!()`, which you can use on unfinished code paths to make your program compile.

[comments]: https://book.cairo-lang.org/ch02-04-comments.html
