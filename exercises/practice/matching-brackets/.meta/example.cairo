use core::dict::Felt252Dict;

pub fn is_paired(value: ByteArray) -> bool {
    let mut stack: Array<u8> = Default::default();
    let mut pairs = paired_brackets();

    let mut i = 0;
    let mut result = true;
    while i < value
        .len() {
            let chr = value[i];
            if chr == '{' || chr == '[' || chr == '(' {
                stack.append(chr);
            } else if chr == '}' || chr == ']' || chr == ')' {
                if stack.is_empty() {
                    result = false;
                    break;
                }

                let mut popped: Array<u8> = Default::default();
                let mut i = 0;
                let mut stop = stack.len() - 1;
                while i < stop {
                    popped.append(*stack[i]);
                    i += 1;
                };

                let last = *stack[stop];
                stack = popped.clone();

                let complement = pairs.get(last.into());
                if complement != chr {
                    result = false;
                    break;
                }
            }
            i += 1;
        };

    if result {
        result = stack.is_empty();
    }

    return result;
}

fn paired_brackets() -> Felt252Dict<u8> {
    let mut pairs: Felt252Dict<u8> = Default::default();
    pairs.insert('{', '}');
    pairs.insert('[', ']');
    pairs.insert('(', ')');
    return pairs;
}
