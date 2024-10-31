# Instructions append

Implementing an efficient and modifiable tree structure in Cairo (or any purely functional language with immutable memory) is challenging because these languages are designed to avoid changing data after it’s created.
This immutability means that instead of updating a tree node directly, a new version of the tree must be created whenever you modify it.

To show why this is the case, imagine a simple binary tree structure where each node has a left and a right child.
Let's say we start with a small tree like this:

```c
       1
      / \
     2   3
```

Now, suppose we want to add a new node `4` as the left child of node `2`.
In a purely functional language (like in Cairo or Haskell), memory is immutable, so we can’t simply add node `4` directly to `2`.
Instead, we have to create a new version of each node along the path from the root to the modified node, because every node along this path now points to a new or modified subtree.

Here’s what the process would look like:

1. **Add Node 4 to Node 2**:  
   - Create a new version of node `2`, which now has `4` as its left child.
  
   ```c
       2'
      / 
     4   
   ```

2. **Update the Root Node**:  
   - Since node `1` originally pointed to the old `2`, we create a new version of the root node `1'` that now points to the updated node `2'` on the left and keeps node `3` on the right.

   ```c
       1'
      / \
     2'  3
   ```

So, the resulting tree becomes:

```c
       1'
      / \
     2'  3
    /
   4
```

This new tree (`1'`) still resembles the original, but with an updated path.
The key point is that we had to re-create each node along the path (`1` to `2`) to preserve immutability, since existing nodes cannot be modified in place.
The original tree still exists (for example, for all references to its original root `1`), while this new tree represents the modified state.

In large trees, this approach can become expensive, as every new modification requires recreating a path of nodes from the root to the updated node, even if only a small part of the tree is actually changed.

Another option is to take advantage of Cairo's dictionaries, which can be used to "simulate" a modifiable data structure.
Because Cairo encourages execution efficiency, as it's generally used in environments that demand it (e.g. to write Starknet smart contracts), we will be
using this dictionary approach to solve the binary search tree problem.
