# Instructions

A local school near you has a very active students' association.
The students' association is managed by a president and once every 2 years, elections are run to elect a new president.
In this year's election, it was decided that a new digital system to count the votes was needed.

The school needs your help building this new system.

## 1. Create a vote counter

One of the first things that the new voting system needs is a vote counter.
This counter is a way to keep track of the votes a particular candidate has.

Create a function `new_vote_counter` that accepts the number of initial votes for a candidate and returns a snapshot of a `VoteCounter` struct, initialized with the given number of initial votes.

```rust
let initial_votes: u32 = 2;
let counter: @VoteCounter = new_vote_counter(initial_votes);
// @VoteCounter {
//     value: 2,
// }
```

## 2. Get number of votes from a counter

You now have a way to create new counters!
But now you realize the new system will also need a way to get the number of votes from a counter.

Create a function `vote_count` that will take a counter (`@VoteCounter`) as an argument and will return the number of votes in the counter.

```rust
let initial_votes: u32 = 3;
let vote_counter: @VoteCounter = new_vote_counter(initial_votes);

let count = vote_count(vote_counter);
// => 3
```

## 3. Increment the votes of a counter

It's finally the time to count the votes!
Now you need a way to increment the votes in a counter.

Create a function `increment_vote_count` that will take a counter (`@VoteCounter`) as an argument and a number of votes, and will increment the counter by that number of votes.

```rust
let votes: u32 = 3;
let vote_counter: @VoteCounter = new_vote_counter(initial_votes);
let vote_counter: VoteCounter = increment_vote_count(vote_counter, 2);

let count = vote_count(@vote_counter);
// => 5
```

## 4. Create the election results

With all the votes now counted, it's time to prepare the result announcement to the whole school.
For this, you notice that having only counters for the votes is insufficient.
There needs to be a way to associate the number of votes with a particular candidate.

Create a function `new_election_result` that receives the name of a candidate and their number of votes and returns a new election result.

```rust
let result: ElectionResult = new_election_result("Peter", 3);
// ElectionResult {
//     name: "Peter",
//     votes: @VoteCounter {
//         value: 3,
//     },
// }
```

The election result struct is already created for you and it's defined as:

```rust
struct ElectionResult {
    name: ByteArray,
    counter: @VoteCounter,
}
```

## 5. Announce the results

It's time to announce the new president to the school!
The president will be announced in the little digital message boards that the school has.

The message should show the name of the new president and the votes they had, in the following format: `<candidate_name> (<votes>)`.
This is an example of such message: `"Peter (51)"`.

Create a function `display_result` that will receive an `@ElectionResult` as an argument and will return a `ByteArray` with the message to display.

```rust
let result = ElectionResult {
    name: "John",
    votes: @VoteCounter {
        value: 32,
    },
};

let msg = display_result(@result);
// => "John (32)"
```

## 6. Vote recounting

To make sure the final results were accurate, the votes were recounted.
In the recount, it was found that the number votes for some of the candidates was off by one.

Create a function `decrement_votes_of_candidate` that receives the final results and the name of a candidate for which you should decrement its vote count.
The final results are given in the form of a `Felt252Dict<u32>`, where the keys are the names of the candidates and the values are its total votes.

```rust
let mut final_results: Felt252Dict<u32> = Default::default();
final_results.insert('Mary', 10);
final_results.insert('John', 51);

decrement_votes_of_candidate(ref final_results, 'Mary');

let decremented_votes = final_results.get('Mary');
// => 9
```
