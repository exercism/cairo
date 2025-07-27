# Introduction

## Modules

Modules are a way to group related code, to avoid name clashes, and are generally present in all but the most trivial code bases.

The syntax is as follows:

```rust
mod my_module {
    pub struct MyStruct {}

    pub struct OtherClass {}
}
```

Outside the scope of the module, types enclosed in modules are referred to by prefixing the type name with the double colon `::` syntax.

Alternatively, and more usually, you can place a `use` directive at the top of the file (or within a module) and then types can be used without the prefix.

Within the same module there is no need to qualify type names.

```rust
mod my_module {
    #[derive(Drop)]
    pub struct MyStruct {}

    pub struct Foo {}

    #[generate_trait]
    pub impl FooImpl of FooTrait {
        fn bar() {
            let baz = MyStruct {};
        }
    }
}

#[derive(Drop)]
pub struct Qux {}

#[generate_trait]
impl QuxImpl of QuxTrait {
    fn box() {
        let nux = my_module::MyStruct {};
    }
}

mod other_module {
    use super::my_module::*;

    #[derive(Drop)]
    pub struct Tix {}

    #[generate_trait]
    pub impl TixImpl of TixTrait {
        fn jeg() {
            let lor = MyStruct {};
        }
    }
}
```

You can alias a module or a type with the syntax `use core::array::ArrayTrait as Arr;` and then use the alias anywhere that the module or type could be used.
