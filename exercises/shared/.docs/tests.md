# Testing on the Command Line

Execute the tests with:

```bash
scarb cairo-test
```

All but the first test have been ignored. After you get the first test to
pass, open the tests source file which is located in the `tests` directory
and remove the `#[ignore]` flag from the next test and get the tests to pass
again. Each separate test is a function with `#[test]` flag above it.
Continue, until you pass every test.

If you wish to run _all_ tests without editing the tests source file, use:

```bash
scarb cairo-test --include-ignored
```

To run a specific test no matter if it's ignored or not, for example `some_test`, you can use:

```bash
scarb cairo-test -f some_test
```

To learn more about Cairo tests refer to the online [test documentation][cairo-tests].

[cairo-tests]: https://book.cairo-lang.org/ch10-01-how-to-write-tests.html
