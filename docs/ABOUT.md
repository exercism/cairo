# About

Cairo is a Rust-inspired language that aims to make it easy to compute trustworthy values on untrusted machines using [validity proofs][zkp].
It is a programming language designed for a virtual CPU of the same name, which is capable of efficiently proving the execution of any program running on it.
This means that you can perform time consuming operations on a machine you don't trust, and check the result very quickly on a cheaper machine.

One major usecase of Cairo is writing smart contracts for [Starknet](https://www.starknet.io/), a Layer 2 built on top of Ethereum. Instead of having all the participants of the network verify all user interactions, only one node, called the prover, executes the programs and generates proofs that the computations were done correctly. These proofs are then verified by an Ethereum smart contract, requiring significantly less computational power, which increases throughput and reduces transaction costs while preserving Ethereum security.

Cairo differs significantly from traditional programming languages, particularly in its execution and performance optimizations. Programs can be executed by a prover, similar to other languages, though with some performance overhead due to virtualization of the language. When proofs are verified, efficiency is crucial as verification may occur on small machines, and Cairo has various advantages to improve verification speed. A notable one is [non-determinism][np], which is the idea that you can theoretically use a different algorithm for verifying than for computing. Take the example of sorting an array in Cairo - the prover has to sort the array, while the verifier only needs to check that the array is sorted, which is much cheaper. Additionally, Cairo's memory model is immutable, meaning values cannot be changed once written. Cairo provides abstractions that help developers work with these constraints, but it does not fully simulate mutability. This means that developers are required to be mindful of memory management and data structures to optimize performance.

The home page for Cairo is [cairo-lang.org](https://www.cairo-lang.org/).
List of Cairo resources at [cairo-lang.org/documentation.html](https://www.cairo-lang.org/resources/).
Newcomers should start with "The Book" located at [book.cairo-lang.org/](https://book.cairo-lang.org/).


[zkp]: https://en.wikipedia.org/wiki/Zero-knowledge_proof
[awe-sn]: https://github.com/keep-starknet-strange/awesome-starknet
[np]: https://en.wikipedia.org/wiki/NP_(complexity)