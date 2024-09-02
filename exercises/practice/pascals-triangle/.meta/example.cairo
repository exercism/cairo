pub fn rows(count: u32) -> Array<Array<u32>> {
    let mut rows: Array<Array<u32>> = array![];

    let mut i = 0;

    while i < count {
        let mut row: Array<u32> = array![];
        let mut j = 0;

        while j <= i {
            if j == 0 || j == i {
                row.append(1);
            } else {
                let values = rows[i - 1];

                let valueA = match values.get(j - 1) {
                    Option::Some(value) => *value.unbox(),
                    Option::None => 0,
                };

                let valueB = match values.get(j) {
                    Option::Some(value) => *value.unbox(),
                    Option::None => 0,
                };

                row.append(valueA + valueB);
            };

            j += 1;
        };

        rows.append(row);
        i += 1;
    };

    return rows;
}
