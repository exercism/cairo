use core::to_byte_array::AppendFormattedToByteArray;
use core::dict::Felt252Dict;

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
    panic!("implement `new_vote_counter`")
}

pub fn vote_count(vote_counter: @VoteCounter) -> u32 {
    panic!("implement `vote_count`")
}

pub fn increment_vote_count(vote_counter: VoteCounter, by: u32) -> VoteCounter {
    panic!("implement `increment_vote_count`")
}

pub fn new_election_result(name: ByteArray, votes: u32) -> ElectionResult {
    panic!("implement `new_election_result`")
}

pub fn display_result(election_result: @ElectionResult) -> ByteArray {
    panic!("implement `display_result`")
}

pub fn decrement_votes_of_candidate(ref final_results: Felt252Dict<u32>, candidate: felt252) {
    panic!("implement `decrement_votes_of_candidate`")
}

// Helper function showing how integers can be converted into the ByteArray type
fn u32_to_bytearray(v: u32) -> ByteArray {
    let mut result = "";
    v.append_formatted_to_byte_array(ref result, 10);
    result
}
