#[derive(Drop, Debug, PartialEq)]
struct Position {
    pub col: usize,
    pub row: usize,
}

#[derive(Debug, PartialEq, Drop)]
pub struct SearchResult {
    pub word: ByteArray,
    pub start: Position,
    pub end: Position,
}

pub fn search(grid: Span<ByteArray>, words_to_search_for: Span<ByteArray>) -> Span<SearchResult> {
    panic!("implement `search`")
}
