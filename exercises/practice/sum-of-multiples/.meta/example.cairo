pub fn sum(limit: u32, factors: Array<u32>) -> u32 {
    let mut multiples: Array<u32> = array![];

    for f in factors {
        if f > 0 {
            let mut multiplier = 1;
            let mut x = f;

            while x < limit {
                if !contains(@multiples, x) {
                    multiples.append(x);
                }

                multiplier += 1;
                x = f * multiplier;
            }
        }
    }

    let mut total_sum = 0;
    for m in multiples {
        total_sum += m;
    }

    total_sum
}

fn contains(arr: @Array<u32>, value: u32) -> bool {
    let mut i = 0;
    let mut result = false;
    while i < arr.len() {
        if arr[i] == @value {
            result = true;
            break;
        }
        i += 1;
    }
    result
}
