# Introduction

When you pass a variable to a function, its ownership is transferred, making the original variable unusable. This can be a bit tedious when accessing a state more than once, but luckily Cairo has two features for passing values without destroying or moving them, called `references` and `snapshots`.
