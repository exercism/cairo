use core::dict::Felt252Dict;

#[derive(Drop)]
pub struct HighScores {
    scores: Array<u32>,
}

#[generate_trait]
pub impl HighScoresImpl of HighScoresTrait {
    fn new(scores: Array<u32>) -> HighScores {
        HighScores { scores }
    }

    fn scores(self: @HighScores) -> Span<u32> {
        self.scores.span()
    }

    fn latest(self: @HighScores) -> Option<u32> {
        match self.scores.get(self.scores.len() - 1) {
            Option::Some(boxed) => Option::Some(*boxed.unbox()),
            _ => Option::None,
        }
    }

    fn personal_best(self: @HighScores) -> Option<u32> {
        if self.scores.is_empty() {
            return Option::None;
        }
        let mut max = 0;
        for score in self.scores.span() {
            if score > @max {
                max = *score;
            }
        }
        Option::Some(max)
    }

    fn personal_top_three(self: @HighScores) -> Span<u32> {
        let sorted = insertion_sort(self.scores.span());
        let take = if sorted.len() > 3 {
            3
        } else {
            sorted.len()
        };
        sorted.span().slice(0, take)
    }
}

fn insertion_sort(span: Span<u32>) -> Array<u32> {
    if span.is_empty() {
        return array![];
    }

    // Felt252Dict enables swapping and moving values
    let mut sorted: Felt252Dict<u32> = Default::default();
    sorted.insert(0, *span[0]);

    // insert all elements in their sorted position
    for i in 1..span.len() {
        let elem = *span[i];
        let mut j: felt252 = i.into();
        while j != 0 && elem > sorted.get(j - 1) {
            sorted.insert(j, sorted.get(j - 1));
            j -= 1;
        }
        sorted.insert(j.into(), elem);
    }

    // collect all elements into an array
    let mut sorted_arr: Array<u32> = array![];
    for i in 0..span.len() {
        sorted_arr.append(sorted.get(i.into()));
    }
    sorted_arr
}
