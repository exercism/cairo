use core::to_byte_array::AppendFormattedToByteArray;

#[derive(Drop, Copy)]
pub struct VoteCounter {
    value: u32,
}

#[derive(Drop)]
pub struct ElectionResult {
    name: ByteArray,
    counter: @VoteCounter,
}

pub fn new_vote_counter(value: u32) -> VoteCounter {
    VoteCounter { value }
}

pub fn vote_count(counter: @VoteCounter) -> u32 {
    *counter.value
}

pub fn increment_vote_count(ref vote_counter: VoteCounter, by: u32) {
    vote_counter.value += by;
}

pub fn new_election_result(name: ByteArray, votes: u32) -> ElectionResult {
    ElectionResult { name, counter: @new_vote_counter(votes) }
}

pub fn display_result(election_result: @ElectionResult) -> ByteArray {
    let mut msg = "";
    msg += election_result.name.clone();
    msg += " (";
    msg += u32_to_bytearray(**election_result.counter.value);
    msg += ")";
    msg
}

fn u32_to_bytearray(v: u32) -> ByteArray {
    let mut result = "";
    v.append_formatted_to_byte_array(ref result, 10);
    result
}
