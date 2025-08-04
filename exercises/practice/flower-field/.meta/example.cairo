// Struct to represent the board
#[derive(Drop)]
struct Board {
    pieces: Span<ByteArray>,
    num_rows: usize,
    num_cols: usize,
}

#[generate_trait]
impl BoardImpl of BoardTrait {
    // Annotates the board by replacing empty squares with flower counts
    fn annotated(self: @Board) -> Array<ByteArray> {
        let mut annotated_board: Array<ByteArray> = array![];
        let num_rows = *self.num_rows;

        // Process each row
        for y in 0..num_rows {
            let annotated_row = self.annotated_row(y);
            annotated_board.append(annotated_row);
        }

        annotated_board
    }

    // Annotates a single row by counting the neighboring flowers
    fn annotated_row(self: @Board, y: usize) -> ByteArray {
        let mut row: ByteArray = "";
        let num_cols = *self.num_cols;

        // Process each cell in the row
        for x in 0..num_cols {
            let c = self.pieces[y].at(x).expect('indexes should be correct');

            // If it's an empty square (' '), count neighboring flowers
            if c == ' ' {
                let char_count = self.count_neighbouring_flowers_char(x, y);
                row.append_byte(char_count);
            } else {
                row.append_byte(c);
            }
        }

        row
    }

    // Counts neighboring flowers for a specific cell and returns the character representation
    fn count_neighbouring_flowers_char(self: @Board, x: usize, y: usize) -> u8 {
        let mut count = 0;
        let num_cols = self.num_cols;
        let num_rows = self.num_rows;

        // Iterate through neighboring cells
        for x1 in neighbouring_points(x, num_cols) {
            for y1 in neighbouring_points(y, num_rows) {
                let piece = self.pieces[y1].at(x1).expect('indexes should be correct');
                if piece == '*' {
                    count += 1;
                }
            }
        }

        // If no flowers are adjacent, return ' ' (empty); otherwise, return the count as a char
        if count == 0 {
            ' '
        } else {
            (count + '0') // Convert to character representation
        }
    }
}

pub fn annotate(pieces: Span<ByteArray>) -> Array<ByteArray> {
    if pieces.len() == 0 {
        return array![];
    }

    let board = Board { pieces, num_rows: pieces.len(), num_cols: pieces.at(0).len() };

    board.annotated()
}

// Helper function to return valid neighboring points for a given x or y coordinate
fn neighbouring_points(x: usize, limit: @usize) -> Array<usize> {
    let mut offsets: Array<usize> = array![x];

    if x >= 1 {
        offsets.append(x - 1);
    }

    if x + 1 < *limit {
        offsets.append(x + 1);
    }

    offsets
}
