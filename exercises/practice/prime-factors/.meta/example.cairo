pub fn factors(n: u64) -> Array<u64> {
    let mut all_prime = ArrayTrait::new();

    let mut num: u64 = n;
    loop {

        for i in 2..(num + 1) {        
            if num % i == 0 {
                num /= i;
                all_prime.append(i);

                break;       
            }
        };
        if num == 1 {
            break;
        }
    };

    all_prime    
}
