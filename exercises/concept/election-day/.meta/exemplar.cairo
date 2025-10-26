use core::dict::Felt252Dict;
use core::to_byte_array::AppendFormattedToByteArray;

#[derive(Drop, Copy)]
pub struct VoteCounter {
    pub value: u32,
}

#[derive(Drop)]
pub struct ElectionResult {
    pub name: ByteArray,
    pub vote_counter: @VoteCounter,
}

pub fn new_vote_counter(value: u32) -> @VoteCounter {
    @VoteCounter { value }
}

pub fn vote_count(vote_counter: @VoteCounter) -> u32 {
    *vote_counter.value
}

pub fn increment_vote_count(vote_counter: @VoteCounter, by: u32) -> VoteCounter {
    VoteCounter { value: vote_count(vote_counter) + by }
}

pub fn new_election_result(name: ByteArray, votes: u32) -> ElectionResult {
    ElectionResult { name, vote_counter: new_vote_counter(votes) }
}

pub fn display_result(election_result: @ElectionResult) -> ByteArray {
    let mut msg = "";
    msg += election_result.name.clone();
    msg += " (";
    msg += u32_to_bytearray(**election_result.vote_counter.value);
    msg += ")";
    msg
}

pub fn decrement_votes_of_candidate(ref final_results: Felt252Dict<u32>, candidate: felt252) {
    let votes = final_results.get(candidate);
    final_results.insert(candidate, votes - 1);
}

// Helper function showing how integers can be converted into the ByteArray type
fn u32_to_bytearray(v: u32) -> ByteArray {
    let mut result = "";
    v.append_formatted_to_byte_array(ref result, 10);
    result
}
