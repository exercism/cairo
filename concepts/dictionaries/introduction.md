# Introduction

Dictionaries in Cairo provide a way to store and retrieve key-value pairs, similar to hash maps or dictionaries in other languages.
However, due to Cairo's unique memory model and its role in generating computational proofs, they work quite differently under the hood - offering $O(n)$ complexity operations and automatic validation through a process called "squashing".
Understanding how Cairo dictionaries differ from their counterparts in other languages is essential for writing efficient Cairo programs.
