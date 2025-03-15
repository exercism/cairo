use election_day::*;

#[test]
fn test_new_vote_counter() {
    // Test "Simple vote counter with 2 votes"
    let vote_counter = new_vote_counter(2);
    assert!(vote_counter.value == 2, "vote_counter.value should be 2");
}

#[test]
#[ignore]
fn test_vote_count() {
    // Test "Call to VoteCount with a pointer to an int with a value of 2"
    let vote_counter = new_vote_counter(2);
    let count = vote_count(@vote_counter);
    assert!(count == 2, "vote_count should return 2");
}

#[test]
#[ignore]
fn test_increment_vote_count() {
    // Test "Call to IncrementVoteCount with a pointer to an int with a value of 0 and increment of
    // 1"
    let mut vote_counter = new_vote_counter(0);
    increment_vote_count(ref vote_counter, 1);
    assert!(vote_counter.value == 1, "counter should be 1 after increment");

    // Test "Call to IncrementVoteCount with a pointer to an int with a value of 2 and increment of
    // 2"
    let mut vote_counter = new_vote_counter(2);
    increment_vote_count(ref vote_counter, 2);
    assert!(vote_counter.value == 4, "counter should be 4 after increment");

    // Test "Call to IncrementVoteCount with a pointer to an int with a value of 5 and increment of
    // 7"
    let mut vote_counter = new_vote_counter(5);
    increment_vote_count(ref vote_counter, 7);
    assert!(vote_counter.value == 12, "counter should be 12 after increment");
}

#[test]
#[ignore]
fn test_new_election_result() {
    // Test "Call to NewElectionResult for Peter with 2 votes"
    let result = new_election_result("Peter", 2);

    assert!(result.name == "Peter", "name should be Peter");
    assert!(*result.counter.value == 2, "votes should be 2");
}

#[test]
#[ignore]
fn test_display_result() {
    // Test "Call to DisplayResult for John with 5 votes"
    let result = new_election_result("John", 5);
    let display = display_result(@result);

    assert!(display == "John (5)", "display should be \"John (5)\"");
}

#[test]
fn test_decrement_votes_of_candidate() {
    // Create a dictionary-like structure using a Felt252Dict
    let mut results = Default::default();

    // Set initial votes for "John" to 3
    results.insert('John', 3);

    // Call the function to decrement votes
    decrement_votes_of_candidate(ref results, 'John');

    // Check if votes were decremented to 2
    let votes = results.get('John');
    assert!(votes == 2, "votes should be decremented to 2");
}
