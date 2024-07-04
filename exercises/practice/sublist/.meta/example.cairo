#[derive(Drop, Debug, PartialEq)]
enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

fn sublist<T, +PartialEq<T>>(a: @Array<T>, b: @Array<T>) -> Comparison {
    let a = a.span();
    let b = b.span();
    if a == b {
        Comparison::Equal
    } else if contains(a, b) {
        Comparison::Superlist
    } else if contains(b, a) {
        Comparison::Sublist
    } else {
        Comparison::Unequal
    }
}

fn contains<T, +PartialEq<T>>(a: Span<T>, b: Span<T>) -> bool {
    if a.len() < b.len() {
        return false;
    }

    let mut i = 0;
    let starts_with = loop {
        if i == b.len() {
            break true;
        }
        if a[i] != b[i] {
            break false;
        }
        i += 1;
    };
    if starts_with {
        return true;
    }

    contains(a.slice(1, a.len() - 1), b)
}

#[cfg(test)]
mod tests;
