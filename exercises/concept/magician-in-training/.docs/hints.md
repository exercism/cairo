# Hints

## 1. Insert a card at the of top the stack

- The [`ArrayTrait::append` function][append] can be used to add to the back of an array.

## 2. Remove the top card from the stack

- You can always convert an array into a span, and then use [`SpanTrait::pop_back` function][pop-back] can be used to remove from the back of an array.

## 3. Insert a card at the bottom of the stack

- There's no way to append an item to the front of the array, but one way around this is to create a new one-item array and append the old one as a span with [`ArrayTrait::append_span`][append-span].

## 4. Remove a card from the bottom of the stack

- The [`ArrayTrait::pop_front` function][pop-front] can be used to remove from the front of an array.

## 5. Check size of the stack

- The [`ArrayTrait::len` function][len] can be used to get the length of an array.

[append]: https://docs.swmansion.com/scarb/corelib/core-array-ArrayTrait.html#append
[pop-back]: https://docs.swmansion.com/scarb/corelib/core-array-SpanTrait.html#pop_back
[append-span]: https://docs.swmansion.com/scarb/corelib/core-array-ArrayTrait.html#append_span
[pop-front]: https://docs.swmansion.com/scarb/corelib/core-array-ArrayTrait.html#pop_front
[len]: https://docs.swmansion.com/scarb/corelib/core-array-ArrayTrait.html#len
