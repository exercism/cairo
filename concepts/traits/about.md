# Traits

A trait specifies a set of methods that a type can implement. Traits are useful for defining methods that should be shared between types. When traits are used with generic types, the defined methods can be called on particular type but also possible to call them on other data type. In an abstract manner, with the use of _trait bounds_, we can specify that the generic type must share certain behavior.

> **Note:** Traits share similar feature to what is known as interfaces in other programming languages with some differences.

## Trait definition

Defining a trait helps identify the function signature that would make up the set of behaviors a type can implement in order to achieve a result. These methods form the behavior of a type. If we can call the same methods on different types, this implies that the involved types have same behavior.

```rust
#[derive(Drop)]
    pub struct NewsArticle {
        pub headline: ByteArray,
        pub location: ByteArray,
        pub author: ByteArray,
        pub content: ByteArray,
    }

// A trait for NewsArticle struct type
pub trait Summary {
    fn summarize(self: @NewsArticle) -> ByteArray;
}
```

Going by the `Summary` trait definition above, the `summarize` method is a behavior that can only be called by the `NewsArticle` struct type. If invoked on other type instances, it throws a compilation error. Declaring the trait with the `pub` keyword exposes the trait in this crate to other crates that intend to make use of the trait too. Notice also that we use a semicolon after declaring method signatures in traits.

A trait could be defined with a generic argument which allows for a function to take in argument of any data type. This introduces a mode of flexibility to function signature to allow them handle varieties of data type. In the case of the `Summary` trait below, this has been redesigned to work for any data type so that when `summarize` method is invoked on them, it returns a ByteArray.

```rust
// A trait for a generic type
pub trait Summary<T> {
    fn summarize(self: @T) -> ByteArray;
}
```

A trait can have more than one method in its body; each declared method signature is a one liner that ends with a semicolon.

## Trait implementation on a Type

After defining the function signatures that make up a trait, the compiler will enforce that an implementation is as well defined for types that adopt the trait. We have written a media `aggregator` library crate below that summarizes some data from instances of `NewsArticle` and `Tweet`. For the `NewsArticle` struct, we would use the headline, the author, and the location types to return the value for the `summarize` method from the `Summary` trait, while for the `Tweet` struct, we would use the username and the content, assuming that the tweet content has a 280 characters limitation.

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

## Default Implementations

Sometimes, a trait can be defined with a default implementation for some or all of the methods that makes up the trait. This is to avoid requiring an implementation of all methods on every type and better code readability. If any particular type requires a special implementation of a trait's method, it can override the default implementation.

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

    println!("New article available! {}", news.summarize()); // prints "New article available! (Read more...)"


    let tweet = Tweet {
        username: "Alice",
        content: "Cairo is fun and engaging.",
        reply: true,
        retweet: true,
    }
    println!("New tweet from {}", tweet.summarize()); // prints "New tweet from Alice: Cairo is fun and engaging."
}
```

## How to Use and Manage External Traits

Traits and implementations can be defined in an external module and used in other modules, as long as they are properly imported. Let's say we have a `ShapeGeometry` trait with the `boundary` method that must be implemented for both the `Circle` and `Rectangle` structs. Below is an example of how the trait and implementation is imported, managed and used across modules.

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

Implementations can be aliased when imported, using the `impl` keyword. This helps when instantiating a generic implementation for concrete types. Let's define a trivial implementation of trait `Two` for all types that implement the `One` trait by simply adding twice the value of `One` and returning the summation. We can afterwards expose the `Two` implementation that works only for `u8` and `u128` types.

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
