#[derive(Debug, PartialEq, Drop)]
pub struct SearchResult {
    word: ByteArray,
    start_col: usize,
    start_row: usize,
    end_col: usize,
    end_row: usize,
}


pub fn search(grid: Array<ByteArray>, wordsToSearchFor: Array<ByteArray>) -> Array<SearchResult> {
    let mut results: Array<SearchResult> = ArrayTrait::new();
    let num_rows = grid.len();
    let num_cols = grid[0].len();

    for word in wordsToSearchFor {
        let word_len = word.len();

        for row in 0
            ..num_rows {
                for col in 0
                    ..num_cols {
                        // Horizontal (left-to-right)
                        if col
                            + word_len <= num_cols && is_horizontal_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + word_len,
                                        end_row: row + 1,
                                    }
                                );
                        }

                        // Horizontal (right-to-left)
                        if col >= word_len
                            - 1 && is_horizontal_reverse_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: word_len - col,
                                        end_row: row + 1,
                                    }
                                );
                        }

                        // Vertical (top-to-bottom)
                        if row + word_len <= num_rows && is_vertical_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + 1,
                                        end_row: row + word_len,
                                    }
                                );
                        }

                        // Vertical (bottom-to-top)
                        if row >= word_len
                            - 1 && is_vertical_reverse_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + 1,
                                        end_row: row + 1 - word_len + 1,
                                    }
                                );
                        }

                        // Diagonal (top-left to bottom-right)
                        if row
                            + word_len <= num_rows && col
                            + word_len <= num_cols
                                && is_diagonal_tl_br_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_row: col + word_len,
                                        end_col: row + word_len,
                                    }
                                );
                        }

                        // Diagonal (top-right to bottom-left)
                        if row
                            + word_len <= num_rows && col >= word_len
                            - 1 && is_diagonal_tr_bl_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + 1 - word_len + 1,
                                        end_row: row + word_len,
                                    }
                                );
                        }
                        // Diagonal Up-Right (Bottom-Left to Top-Right)
                        if row >= word_len.into()
                            && is_diagonal_bl_tr_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + word_len,
                                        end_row: row + 1 - word_len + 1,
                                    }
                                );
                        }
                        // Diagonal Up-Left (Bottom-Right to Top-Left)
                        if row >= word_len.into()
                            && col >= word_len.into()
                            && is_diagonal_br_tl_match(@grid, @word, row, col) {
                            results
                                .append(
                                    SearchResult {
                                        word: word.clone(),
                                        start_col: col + 1,
                                        start_row: row + 1,
                                        end_col: col + 1 - word_len + 1,
                                        end_row: row + 1 - word_len + 1,
                                    }
                                );
                        }
                    }
            }
    };

    results
}


// Helper function to check for Different direction

// Horizontal match (left-to-right)
fn is_horizontal_match(grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize) -> bool {
    let mut result = true;
    let word_len = word.len();

    if col + word_len.into() > grid[row.into()].len().into() {
        return false;
    }
    for i in 0
        ..word_len {
            if grid[row.into()][col.into() + i] != word[i] {
                result = false;
                break;
            }
        };
    result
}

// Horizontal match (right-to-left)
fn is_horizontal_reverse_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;
    let word_len = word.len();
    // Check if the starting column is valid for a right-to-left match
    if col < word_len.into() - 1 {
        return false;
    }

    for i in 0
        ..word_len {
            if grid[row.into()][col.into() - i] != word[i] {
                result = false;
                break;
            }
        };
    result
}

// Vertical match (top-to-bottom)
fn is_vertical_match(grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize) -> bool {
    let mut result = true;
    let word_len = word.len();

    if row + word_len.into() > grid.len().into() {
        return false;
    }
    for i in 0
        ..word_len {
            if grid[row.into() + i][col.into()] != word[i] {
                result = false;
                break;
            }
        };
    result
}

// Vertical match (bottom-to-top)
fn is_vertical_reverse_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;
    let word_len = word.len();

    if row < word_len.into() - 1 {
        return false;
    }
    for i in 0
        ..word_len {
            if grid[row.into() - i][col.into()] != word[i] {
                result = false;
                break;
            }
        };
    result
}

// Diagonal match (top-left to bottom-right)
fn is_diagonal_tl_br_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;
    let word_len = word.len();

    if row
        + word_len.into() > grid.len().into() || col
        + word_len.into() > grid[row.into()].len().into() {
        return false;
    }
    for i in 0
        ..word_len {
            if grid[row.into() + i][col.into() + i] != word[i] {
                result = false;
                break;
            }
        };

    result
}

// Diagonal match (top-right to bottom-left)
fn is_diagonal_tr_bl_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;
    let word_len = word.len();

    if row + word_len.into() > grid.len().into() || col < word_len.into() - 1 {
        println!("get");
        return false;
    }
    for i in 0
        ..word_len {
            if grid[row.into() + i][col.into() - i] != word[i] {
                result = false;
                break;
            }
        };

    result
}

fn is_diagonal_bl_tr_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;

    let word_len = word.len();

    // Check if the starting row and column allow the word to fit diagonally
    if row < word_len.into() || col + word_len.into() > grid[row].len().into() {
        return false;
    }

    for i in 0
        ..word_len {
            if grid[row.into() - i][col.into() + i] != word[i] {
                result = false;
                break;
            }
        };
    result
}

fn is_diagonal_br_tl_match(
    grid: @Array<ByteArray>, word: @ByteArray, row: usize, col: usize
) -> bool {
    let mut result = true;
    let word_len = word.len();

    // Check if the starting row and column allow the word to fit in this diagonal direction
    if word_len.into() > row || col < word_len.into() {
        return false;
    }

    for i in 0
        ..word_len {
            if grid[row.into() - i][col.into() - i] != word[i] {
                result = false;
                break;
            }
        };

    result
}
