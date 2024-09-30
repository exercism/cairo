// Define the recursive ChronoChain enum
#[derive(Copy, Drop)]
pub enum ChronoChain {
    End,
    Link: (u32, Box<ChronoChain>),
}

// Function to build a ChronoChain from an array of u32 values
pub fn build_chrono_chain(arr: Array<u32>) -> Box<ChronoChain> {
    let mut chain = ChronoChain::End;

    // Iterate in reverse to build the chain from the end to the beginning
    let mut span = arr.span();
    while let Option::Some(value) = span.pop_back() {
        chain = ChronoChain::Link((*value, BoxTrait::new(chain)));
    };

    BoxTrait::new(chain)
}

// Function to sum the values in the ChronoChain
pub fn sum_chain(chain: @ChronoChain) -> u32 {
    match chain {
        ChronoChain::End => 0,
        ChronoChain::Link((value, next)) => *value + sum_chain(@(*next).unbox()),
    }
}
