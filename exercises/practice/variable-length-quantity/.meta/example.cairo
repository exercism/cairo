pub fn encode(integers: Array<u32>) -> Array<u32> {
    let mut result = ArrayTrait::<u32>::new();

    for integer in integers {
        let mut value = integer;
        let mut temp_result = ArrayTrait::<u32>::new();

        if value == 0 {
            temp_result.append(0);
        }
        while value > 0 {
            // take the lower 7 bits
            let mut tmp = value & 0x7f;
            // remove them from the original value
            value = value / 128;

            // set continuation bit
            if !temp_result.is_empty() {
                tmp = tmp | 0x80;
            }

            temp_result.append(tmp);
        };

        temp_result = reverse_array(temp_result);

        for temp in temp_result {
            result.append(temp);
        };
    };
    result
}

pub fn decode(integers: Array<u32>) -> Array<u32> {
    let mut res = ArrayTrait::<u32>::new();
    let size = integers.len();
    let mut tmp = 0;
    let mut i = 0;
    for integer in integers {
        tmp = (tmp * 0x80) | (integer & 0x7f);

        if 0x80 & integer == 0 {
            // continuation bit not set, number if complete
            res.append(tmp);
            tmp = 0;
        } else {
            // check for incomplete bytes
            if i + 1 == size {
                // the next index would be past the end,
                // i.e. there are no more bytes.
                panic!("incomplete sequence");
            }
        }
        i += 1;
    };

    res
}

fn reverse_array(arr: Array<u32>) -> Array<u32> {
    let mut reversed: Array<u32> = ArrayTrait::new();

    let mut i = arr.len();
    while i > 0 {
        i -= 1;
        reversed.append(*arr[i]);
    };

    reversed
}
