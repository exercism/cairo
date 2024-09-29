fn sum_of_multiples(limit: u32, factors: Array<u32>) -> u32 {
  
    let mut multiples: Array<u32> = ArrayTrait::new();

    let mut i = 0;
    while i < factors.len() {
        let f = *factors[i];

        if f > 0 {
            let mut multiplier = 1;
            let mut x = f;

            while @x < @limit {
                if !contains(@multiples, x) {
                    multiples.append(x);
                };

                multiplier += 1;
                x = f * multiplier;
            }
        }

        i += 1;
    };

    let mut total_sum = 0;
    let mut j = 0;
    while j < multiples.len() {
        total_sum += *multiples[j];
        j += 1;
    };

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
    };
    result
}
