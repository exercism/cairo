// Define the recursive ChronoChain enum
#[derive(Copy, Drop)]
pub enum ChronoChain {
    End,
    Link: (u32, Box<ChronoChain>),
}

#[generate_trait]
pub impl ChronoChainImpl of ChronoChainTrait {
    // Function to build a ChronoChain from an array of u32 values
    fn build(arr: Array<u32>) -> ChronoChain {
        let mut chain = ChronoChain::End;

        // Iterate in reverse to build the chain from the end to the beginning
        let mut span = arr.span();
        while let Option::Some(value) = span.pop_back() {
            chain = ChronoChain::Link((*value, BoxTrait::new(chain)));
        }

        chain
    }

    // Function to sum the values in the ChronoChain
    fn sum(self: ChronoChain) -> u64 {
        match self {
            ChronoChain::End => 0,
            ChronoChain::Link((value, next)) => value.into() + next.unbox().sum(),
        }
    }
}
