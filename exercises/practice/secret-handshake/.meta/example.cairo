pub fn commands(number: u8) -> Array<ByteArray> {
    let mut results: Array<ByteArray> = array![];

    let mut i: u32 = 0;
    for action in actions() {
        if number.into() & (1 * pow(2, i)) != 0 {
            results.append(action);
        }
        i += 1;
    };

    if number & 16 != 0 {
        let mut reversed: Array<ByteArray> = array![];
        let mut i = results.len();
        while i > 0 {
            i -= 1;
            reversed.append(results[i].clone());
        };

        results = reversed;
    }

    results
}

fn actions() -> Array<ByteArray> {
    array!["wink", "double blink", "close your eyes", "jump"]
}

fn pow(base: u32, mut power: u32) -> u32 {
    if base == 0 {
        return base;
    }
    let base: u256 = base.into();
    let mut result = 1_u256;
    while power != 0 {
        result *= base;
        power -= 1;
    };
    result.try_into().expect('too large to fit output type')
}
