#[derive(Drop,)]
pub struct HighScores {}

#[generate_trait]
pub impl HighScoresImpl of HighScoresTrait {
    fn new(scores: Array<u32>) -> HighScores {
        panic!("implement `new`")
    }

    fn scores(self: @HighScores) -> Span<u32> {
        panic!("implement `scores`")
    }

    fn latest(self: @HighScores) -> Option<u32> {
        panic!("implement `latest`")
    }

    fn personal_best(self: @HighScores) -> Option<u32> {
        panic!("implement `personal_best`")
    }

    fn personal_top_three(self: @HighScores) -> Span<u32> {
        panic!("implement `personal_top_three`")
    }
}
