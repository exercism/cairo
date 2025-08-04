use core::dict::Felt252Dict;

#[derive(Drop)]
pub struct Item {
    pub weight: u32,
    pub value: u32,
}

/// Matrix implemented as a 1D array.
#[derive(Destruct)]
struct Matrix {
    // Use Felt252Dict to simulate a modifiable array.
    dict: Felt252Dict<u32>,
    num_of_cols: usize,
}

#[generate_trait]
impl MatrixImpl of MatrixTrait {
    fn new(num_of_cols: usize) -> Matrix {
        Matrix { dict: Default::default(), num_of_cols }
    }

    fn at(ref self: Matrix, row: usize, col: usize) -> u32 {
        self.dict.get((row * self.num_of_cols + col).into())
    }

    fn set(ref self: Matrix, row: usize, col: usize, value: u32) {
        self.dict.insert((row * self.num_of_cols + col).into(), value);
    }
}

pub fn maximum_value(maximum_weight: u32, items: Span<Item>) -> u32 {
    let mut max_values = MatrixTrait::new(num_of_cols: maximum_weight + 1);

    for row in 1..items.len() + 1 {
        let item_index = row - 1;
        let item_weight = *items[item_index].weight;
        let item_value = *items[item_index].value;

        for w in 0..maximum_weight + 1 {
            if item_weight <= w {
                let max_val = core::cmp::max(
                    max_values.at(item_index, w),
                    max_values.at(item_index, w - item_weight) + item_value,
                );
                max_values.set(row, w, max_val);
            } else {
                max_values.set(row, w, max_values.at(item_index, w));
            }
        }
    }

    max_values.at(items.len(), maximum_weight)
}
