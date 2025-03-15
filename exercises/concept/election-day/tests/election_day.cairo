use election_day::*;

#[test]
fn test_new_vote_counter() {
    let vote_counter = new_vote_counter(2);
    assert!(vote_counter.value == 2, "vote_counter.value should be 2");
}

#[test]
#[ignore]
fn test_vote_count() {
    let vote_counter = new_vote_counter(2);
    let count = vote_count(@vote_counter);
    assert!(count == 2, "vote_count should return 2");
}

#[test]
#[ignore]
fn test_increment_vote_count() {
    let mut vote_counter = new_vote_counter(0);
    increment_vote_count(ref vote_counter, 1);
    assert!(vote_counter.value == 1, "counter should be 1 after increment");

    let mut vote_counter = new_vote_counter(2);
    increment_vote_count(ref vote_counter, 2);
    assert!(vote_counter.value == 4, "counter should be 4 after increment");

    let mut vote_counter = new_vote_counter(5);
    increment_vote_count(ref vote_counter, 7);
    assert!(vote_counter.value == 12, "counter should be 12 after increment");
}

#[test]
#[ignore]
fn test_new_election_result() {
    let result = new_election_result("Peter", 2);

    assert!(result.name == "Peter", "name should be Peter");
    assert!(*result.counter.value == 2, "votes should be 2");
}

#[test]
#[ignore]
fn test_display_result() {
    let result = new_election_result("John", 5);
    let display = display_result(@result);

    assert!(display == "John (5)", "display should be \"John (5)\"");
}

#[test]
fn test_decrement_votes_of_candidate() {
    let mut results = Default::default();

    results.insert('John', 3);

    decrement_votes_of_candidate(ref results, 'John');

    let votes = results.get('John');
    assert!(votes == 2, "votes should be decremented to 2");
}
