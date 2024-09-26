#[derive(Debug, Drop, PartialEq)]
pub enum Classification {
    Deficient,
    Perfect,
    Abundant,
}

pub fn classify(number: u64) -> Classification {
    assert!(number > 0, "Classification is only possible for positive integers.");
    if number == 1 {
        return Classification::Deficient;
    };

    let mut sum = 1;
    let mut i = 2;
    let stop = sqrt(number);

    while i < stop {
        if number % i == 0 {
            let mut increment = i;
            if i * i != number {
                increment += number / i;
            }
            sum += increment;
        }
        i += 1;
    };

    if sum < number {
        Classification::Deficient
    } else if sum > number {
        Classification::Abundant
    } else {
        Classification::Perfect
    }
}

fn sqrt(radicand: u64) -> u64 {
    let mut candidate = 1;
    if radicand > 2 {
        while (candidate * candidate) < radicand {
            candidate += 1;
        };
    }

    return candidate;
}
