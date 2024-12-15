use core::num::traits::Pow;

pub fn commands(number: u8) -> Array<ByteArray> {
    let mut results: Array<ByteArray> = array![];

    let mut i: u32 = 0;
    for action in actions() {
        if number.into() & 2_u32.pow(i) != 0 {
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
