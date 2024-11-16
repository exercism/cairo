#[derive(Debug, PartialEq, Clone, Drop)]
pub struct WordResult {
    pub word: ByteArray,
    pub count: u64,
}

pub fn count_words(phrase: ByteArray) -> Span<WordResult> {
    panic!("implement `count_words`")
}
