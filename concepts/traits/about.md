# Traits

A trait specifies a set of methods that a type can implement. Traits are useful for defining methods that should be shared between types. When traits are used with generic types, the defined methods can be called on particular type but also possible to call them on other data type. In an abstract manner, with the use of _trait bounds_, we can specify that the generic type must share certain behavior.

> **Note:** Traits share similar feature to what is known as interfaces in other programming languages with some differences.

## Trait definition

Defining a trait helps identify the function signature that would make up the set of behaviors a type can implement in order to achieve a result. These methods form the behavior of a type. If we can call the same methods on different types, this implies that the involved types have same behavior.

Let's define a `Summary` trait with the `summarize` method in order to form the behavior for a `NewsArticle` type, considering that `NewsArticle` is a struct holding the news story of a location.

```rust
// A trait for NewsArticle struct type
pub trait Summary {
    fn summarize(self: @NewsArticle) -> ByteArray;
}
```

Going by the `Summary` trait definition above, the `summarize` method is a behavior that can only be called by the NewsArticle struct type. If invoked on other type instances, it throws a compilation error. Declaring the trait with the `pub` keyword exposes this create to other creates that intend to make use of the trait too. Notice also, how in traits after declaring the method signature, it ends with a semicolon.

```rust
// A trait for a generic type
pub trait Summary<T> {
    fn summarize(self: @T) -> ByteArray;
}
```

> **Note:** In Cairo, `ByteArray` type is used to represent strings.

A trait can have more than one method in its body; each declared method signature is a one liner that ends with a semicolon.

## Trait implementation on a Type

After defining the function signatures that make up a trait, the compiler will enforce that an implementation is as well defined for types that adopt the trait. We have written a media _`aggregator`_ library create below that summarizes some data from instances of `NewsArticle` and `Tweet`. For the `NewsArticle` struct, we would use the headline, the author, and the location types to return the value for the `summarize` method from the `Summary` trait, while for the `Tweet` struct, we would use the username and the content, assuming that the tweet content has a 280 characters limitation.

```rust
mod aggregator {
    pub trait Summary<T> {
        fn summarize(self: @T) -> ByteArray;
    }

    #[derive(Drop)]
    pub struct NewsArticle {
        pub headline: ByteArray,
        pub location: ByteArray,
        pub author: ByteArray,
        pub content: ByteArray,
    }

    impl NewsArticleSummary of Summary<NewsArticle> {
        fn summarize(self: @NewsArticle) -> ByteArray {
            format!("{} by {} ({})", self.headline, self.author, self.location)
        }
    }

    #[derive(Drop)]
    pub struct Tweet {
        pub username: ByteArray,
        pub content: ByteArray,
        pub reply: bool,
        pub retweet: bool,
    }

    impl TweetSummary of Summary<Tweet> {
        fn summarize(self: @Tweet) -> ByteArray {
            format!("{}: {}", self.username, self.content)
        }
    }
}

use aggregator::{Summary, NewsArticle, Tweet};

fn main() {
    let news = NewsArticle {
        headline: "Cairo has become the most popular language for developers",
        location: "Worldwide",
        author: "Cairo Digger",
        content: "Cairo is a new programming language for zero-knowledge proofs",
    };

    let tweet = Tweet {
        username: "EliBenSasson",
        content: "Crypto is full of short-term maximizing projects. \n @Starknet and @StarkWareLtd are about long-term vision maximization.",
        reply: false,
        retweet: false
    }; // Tweet instantiation

    println!("New article available! {}", news.summarize());
    println!("New tweet! {}", tweet.summarize());
}
```

Trait implementation appears similar as a regular function declaration however, the difference is that the former implements the code for the method signature defined in a trait. To declare the trait implementation, we use the `impl` keyword, the name of the implementation, then the `of` keyword that recognizes which trait to implement for. If this is a trait for a generic type, we put the generic type in the angle bracket close to the trait name.

Since this is aimed at declaring the logic for the trait method signatures, these methods will no longer be a one liner ending with a semicolon but rather a curly braces with the function logic within. These methods can afterwards be invoked like any other function call on a data type.

It is important to note that for a trait to be accessible, the implementation must be visible within the scope where the method is invoked. You will witness the compiler error if the trait is `pub` and the implementation is not visible within the scope where a trait method is called.

## Default Implementations

Sometimes, a trait can be defined with a default implementation for some or all of the methods that makes up the trait. This is to avoid requiring an implementation of all methods on every type and better code readability. If any particular type requires a special implementation of a trait's method, the default implementation could be override.

```rust
mod aggregator {
    pub trait Summary<T> {
        fn summarize(self: @T) -> ByteArray {
            "(Read more...)"
        }
    }

    #[derive(Drop)]
    pub struct NewsArticle {
        pub headline: ByteArray,
        pub location: ByteArray,
        pub author: ByteArray,
        pub content: ByteArray,
    }

    impl NewsArticleSummary of Summary<NewsArticle> {}

    #[derive(Drop)]
    pub struct Tweet {
        pub username: ByteArray,
        pub content: ByteArray,
        pub reply: bool,
        pub retweet: bool,
    }

    impl TweetSummary of Summary<Tweet> {
        fn summarize(self: @Tweet) -> ByteArray {
            format!("{}: {}", self.username, self.content)
        }
    }
}

use aggregator::{Summary, NewsArticle};

fn main() {
    let news = NewsArticle {
        headline: "Cairo has become the most popular language for developers",
        location: "Worldwide",
        author: "Cairo Digger",
        content: "Cairo is a new programming language for zero-knowledge proofs",
    };

    println!("New article available! {}", news.summarize());
}
```

The default implementation returns `"(Read more...)"` ByteArray when this trait is implemented on any type. To use this default, you declare the impl block with an empty block.

```rust
impl NewsArticleSummary of Summary<NewsArticle> {}
```

When the `summarize` method is called on the `NewsArticle` struct, this prints `New article available! (Read more...)`.

This will be a different case for the `Twitter` struct since the implementation was changed. To override, the syntax is very much the same as defining an implementation with unique code blocks for the data types.

## How to Use and Manage External Trait

Traits and implementations can be defined in an external module and used across other modules supposing it is appropriately imported. We have a `ShapeGeometry` trait with the `boundary` method that must be implemented for both the `Circle` and `Rectangle` structs. This is how the traits and implementation is imported, managed and used across modules.

```rust
// Here T is an alias type which will be provided during implementation
pub trait ShapeGeometry<T> {
    fn boundary(self: T) -> u64;
    fn area(self: T) -> u64;
}

mod rectangle {
    // Importing ShapeGeometry is required to implement this trait for Rectangle
    use super::ShapeGeometry;

    #[derive(Copy, Drop)]
    pub struct Rectangle {
        pub height: u64,
        pub width: u64,
    }

    // Implementation RectangleGeometry passes in <Rectangle>
    // to implement the trait for that type
    impl RectangleGeometry of ShapeGeometry<Rectangle> {
        fn boundary(self: Rectangle) -> u64 {
            2 * (self.height + self.width)
        }
        fn area(self: Rectangle) -> u64 {
            self.height * self.width
        }
    }
}

mod circle {
    // Importing ShapeGeometry is required to implement this trait for Circle
    use super::ShapeGeometry;

    #[derive(Copy, Drop)]
    pub struct Circle {
        pub radius: u64
    }

    // Implementation CircleGeometry passes in <Circle>
    // to implement the imported trait for that type
    impl CircleGeometry of ShapeGeometry<Circle> {
        fn boundary(self: Circle) -> u64 {
            (2 * 314 * self.radius) / 100
        }
        fn area(self: Circle) -> u64 {
            (314 * self.radius * self.radius) / 100
        }
    }
}

use rectangle::Rectangle;
use circle::Circle;

fn main() {
    let rect = Rectangle { height: 5, width: 7 };
    println!("Rectangle area: {}", ShapeGeometry::area(rect)); //35
    println!("Rectangle boundary: {}", ShapeGeometry::boundary(rect)); //24

    let circ = Circle { radius: 5 };
    println!("Circle area: {}", ShapeGeometry::area(circ)); //78
    println!("Circle boundary: {}", ShapeGeometry::boundary(circ)); //31
}
```

The implementation visibility for both the `CircleGeometry` and `RectangleGeometry` does not need to be public since the `ShapeGeometry` trait is made public and should be easily found by the compiler.

## Impl Aliases

Implementation, when imported, can be labeled as `impl` as an alternative name. This helps when instantiating a generic implementation for concrete types. Let's define a trivial `Two` implementation for all types that implement the `One` trait by simply adding twice the value of one and returning the summation. We can afterwards make available for use an implementation that works for u8 and u128 types.

```rust
trait Two<T> {
    fn two() -> T;
}

mod one_based {
    pub impl TwoImpl<
        T, +Copy<T>, +Drop<T>, +Add<T>, impl One: core::num::traits::One<T>
    > of super::Two<T> {
        fn two() -> T {
            One::one() + One::one()
        }
    }
}

pub impl U8Two = one_based::TwoImpl<u8>;
pub impl U128Two = one_based::TwoImpl<u128>;
```

The generic implementation can be written in a private module and with the use of impl alias, we can instantiate the generic implementation of these two concrete types. The benefit of using a private and unexposed generic implementation is that it prevents code duplication across files. This as well keeps the public API simple and clean.

## Negative Implementation

Negative implementation is a technique used to identify when a type does not implement a specific trait while defining a trait implementation for a generic type. Negative impls states the scope for which an implementation is applicable when another implementation does not fall within the existing scope. This is otherwise referred to as `negative trait` or `negative bound`.

Supposing we have a Producer and Consumer traits. We intend to create a generic behavior that expects all types to implement the Consumer trait by default, considering that no one type must implement both Producer and Consumer traits. With the negative impl feature, we can do an explicit restriction.

> **Note:** Being an experimental feature, to use this, you have to add `experimental-features = ["negative_impls"]` in your package Scarb.toml file.

```rust
#[derive(Drop)]
struct ProducerType {}

#[derive(Drop, Debug)]
struct AnotherType {}

#[derive(Drop, Debug)]
struct AThirdType {}

trait Producer<T> {
    fn produce(self: T) -> u32;
}

trait Consumer<T> {
    fn consume(self: T, input: u32);
}

impl ProducerImpl of Producer<ProducerType> {
    fn produce(self: ProducerType) -> u32 {
        42
    }
}

impl TConsumerImpl<T, +core::fmt::Debug<T>, +Drop<T>, -Producer<T>> of Consumer<T> {
    fn consume(self: T, input: u32) {
        println!("{:?} consumed value: {}", self, input);
    }
}

fn main() {
    let producer = ProducerType {};
    let another_type = AnotherType {};
    let third_type = AThirdType {};
    let production = producer.produce();

     producer.consume(production); //Invalid: ProducerType does not implement Consumer
    another_type.consume(production);
    third_type.consume(production);
}
```

On inspecting the `main` function, noticed how we created instances of `producer`, `another_type` and `third_type`. Afterwards, we invoked the `produce` function on the `producer` instance and and pass the result - `production` - to the `consume` function called on the `another_type` and `third_type` instances. The commented part of the code will cause a compile-time error because the `ProducerType` instance does not define the `Consumer` trait.

If you run the code without following what was pointed out at the `note` section, your compiler will throw this error:

```bash
error: Negative impls are not enabled in the current crate.
 --> lib.cairo:24:55
impl TConsumerImpl<T, +core::fmt::Debug<T>, +Drop<T>, -Producer<T>> of Consumer<T> {
                                                      ^**********^
```
