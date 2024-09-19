pub fn nth(n: u32) -> u32 {
    if n == 0 {
        panic!("there is no zeroth prime")
    } else if n == 1 {
        2
    } else {
        let mut count = 1;
        let mut candidate = 1;
        while count < n {
            candidate += 2;
            if is_prime(candidate) {
                count += 1;
            }
        };
        candidate
    }
}

fn is_prime(n: u32) -> bool {
    let mut result = true;
    let mut i = 3;
    while (i * i) < (n + 1) {
        if n % i == 0 {
            result = false;
            break;
        }
        i += 1;
    };
    result
}
