// Struct to represent the board
#[derive(Drop)]
struct Board {
    pieces: Array<ByteArray>,
    num_rows: usize,
    num_cols: usize,
}

#[generate_trait]
impl BoardImpl of BoardTrait {
    // Annotates the board by replacing empty squares with mine counts
    fn annotated(self: @Board) -> Array<ByteArray> {
        let mut annotated_board = ArrayTrait::<ByteArray>::new();
        let num_rows = *self.num_rows;

        // Process each row
        for y in 0
            ..num_rows {
                let annotated_row = self.annotated_row(y);
                annotated_board.append(annotated_row);
            };
        annotated_board
    }

    // Annotates a single row by counting the neighboring mines
    fn annotated_row(self: @Board, y: usize) -> ByteArray {
        let mut row: ByteArray = "";
        let num_cols = *self.num_cols;

        // Process each cell in the row
        for x in 0
            ..num_cols {
                let c = self.pieces.at(y).at(x).expect('indexes should be correct');

                // If it's an empty square (' '), count neighboring mines
                if c == ' ' {
                    let char_count = self.count_neighbouring_mines_char(x, y);
                    row.append_byte(char_count);
                } else {
                    row.append_byte(c);
                }
            };
        row
    }

    // Counts neighboring mines for a specific cell and returns the character representation
    fn count_neighbouring_mines_char(self: @Board, x: usize, y: usize) -> u8 {
        let mut count = 0;
        let num_cols = self.num_cols;
        let num_rows = self.num_rows;

        // Iterate through neighboring cells
        for x1 in neighbouring_points(
            x, num_cols
        ) {
            for y1 in neighbouring_points(
                y, num_rows
            ) {
                let piece = self.pieces.at(y1).at(x1).expect('indexes should be correct');
                if piece == '*' {
                    count += 1;
                }
            }
        };

        // If no mines are adjacent, return ' ' (empty); otherwise, return the count as a char
        if count == 0 {
            ' '
        } else {
            (count + '0') // Convert to character representation
        }
    }
}

pub fn annotate(pieces: Array<ByteArray>) -> Array<ByteArray> {
    if pieces.len() == 0 {
        return array![];
    }

    let board = Board {
        pieces: pieces.clone(), num_rows: pieces.len(), num_cols: pieces.at(0).len(),
    };

    board.annotated()
}

// Helper function to return valid neighboring points for a given x or y coordinate
fn neighbouring_points(x: usize, limit: @usize) -> Array<usize> {
    let mut offsets: Array<usize> = array![];
    offsets.append(x);

    if x >= 1 {
        offsets.append(x - 1);
    }

    if x + 1 < *limit {
        offsets.append(x + 1);
    }

    offsets
}
