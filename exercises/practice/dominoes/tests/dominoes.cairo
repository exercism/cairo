use core::dict::Felt252Dict;
use dominoes::{Domino, chain};

#[derive(Debug)]
enum CheckResult {
    GotInvalid, // chain returned None
    Correct,
    ChainingFailure: Array<
        Domino,
    >, // failure to match the dots at the right side of one domino with
    // the one on the left side of the next
    LengthMismatch: Array<Domino>,
    DominoMismatch: Array<Domino> // different dominoes are used in input and output
}

fn normalize(d: Domino) -> Domino {
    let (m, n) = d;
    if m > n {
        (n, m)
    } else {
        (m, n)
    }
}

fn check(input: @Array<Domino>) -> CheckResult {
    match chain(input) {
        Option::None => CheckResult::GotInvalid,
        Option::Some(output) => {
            if input.len() != output.len() {
                return CheckResult::LengthMismatch(output);
            } else if input.is_empty() {
                // and thus output.is_empty()
                return CheckResult::Correct;
            }

            let mut output_sorted = sort(@output);
            let mut input_sorted = sort(input);
            if input_sorted != output_sorted {
                return CheckResult::DominoMismatch(output);
            }

            // both input and output have at least 1 element
            // This essentially puts the first element after the last one, thereby making it
            // easy to check whether the domino chains "wraps around".
            let (_, mut n): Domino = *output.at(0);
            let mut i = 1;
            loop {
                if i == output.len() {
                    break CheckResult::Correct;
                }
                let (first, second): Domino = *output.at(i);
                if n != first {
                    break CheckResult::ChainingFailure(output);
                }
                n = second;
                i += 1;
            }
        },
    }
}

impl DominoPartialOrd of PartialOrd<Domino> {
    fn le(lhs: Domino, rhs: Domino) -> bool {
        let (l_x, l_y) = lhs;
        let (r_x, r_y) = rhs;
        l_x < r_x || (l_x == r_x && l_y <= r_y)
    }

    fn ge(lhs: Domino, rhs: Domino) -> bool {
        let (l_x, l_y) = lhs;
        let (r_x, r_y) = rhs;
        l_x > r_x || (l_x == r_x && l_y >= r_y)
    }

    fn lt(lhs: Domino, rhs: Domino) -> bool {
        let (l_x, l_y) = lhs;
        let (r_x, r_y) = rhs;
        l_x < r_x || (l_x == r_x && l_y < r_y)
    }

    fn gt(lhs: Domino, rhs: Domino) -> bool {
        let (l_x, l_y) = lhs;
        let (r_x, r_y) = rhs;
        l_x > r_x || (l_x == r_x && l_y > r_y)
    }
}

fn sort(arr: @Array<Domino>) -> Array<Domino> {
    let mut sorted_arr: Array<Domino> = array![];
    let mut sorted_len = 0;

    let mut visited: Felt252Dict<bool> = Default::default();
    while arr.len() != sorted_len {
        let min_domino_index = next_min_index(arr, ref visited);
        sorted_arr.append(normalize(*arr[min_domino_index]));
        visited.insert(min_domino_index.into(), true);
        sorted_len += 1;
    };

    sorted_arr
}

fn next_min_index(arr: @Array<Domino>, ref visited: Felt252Dict<bool>) -> usize {
    let mut next_min_domino_index = 0;
    while visited.get(next_min_domino_index) {
        next_min_domino_index += 1;
    };
    let mut min_domino_index: usize = next_min_domino_index.try_into().unwrap();

    let mut i = arr.len();
    while i != 0 {
        i -= 1;
        if !visited.get(i.into()) {
            if normalize(*arr[i]) < normalize(*arr[min_domino_index]) {
                min_domino_index = i;
            }
        }
    };
    min_domino_index
}

fn assert_correct(input: @Array<Domino>) {
    match check(input) {
        CheckResult::Correct => (),
        CheckResult::GotInvalid => panic!("Unexpectedly got invalid on input {input:?}"),
        CheckResult::ChainingFailure(output) => {
            panic!("Chaining failure for input {input:?}, output {output:?}")
        },
        CheckResult::LengthMismatch(output) => {
            panic!("Length mismatch for input {input:?}, output {output:?}")
        },
        CheckResult::DominoMismatch(output) => {
            panic!("Domino mismatch for input {input:?}, output {output:?}")
        },
    }
}

#[test]
fn empty_input_empty_output() {
    let input: Array<Domino> = array![];
    assert_eq!(chain(@input), Option::Some(array![]));
}

#[test]
#[ignore]
fn singleton_input_singleton_output() {
    let input: Array<Domino> = array![(1, 1)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn singleton_that_cant_be_chained() {
    let input: Array<Domino> = array![(1, 2)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}

#[test]
#[ignore]
fn three_elements() {
    let input: Array<Domino> = array![(1, 2), (3, 1), (2, 3)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn can_reverse_dominoes() {
    let input: Array<Domino> = array![(1, 2), (1, 3), (2, 3)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn cant_be_chained() {
    let input: Array<Domino> = array![(1, 2), (4, 1), (2, 3)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}

#[test]
#[ignore]
fn disconnected_simple() {
    let input: Array<Domino> = array![(1, 1), (2, 2)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}

#[test]
#[ignore]
fn disconnected_double_loop() {
    let input: Array<Domino> = array![(1, 2), (2, 1), (3, 4), (4, 3)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}

#[test]
#[ignore]
fn disconnected_single_isolated() {
    let input: Array<Domino> = array![(1, 2), (2, 3), (3, 1), (4, 4)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}

#[test]
#[ignore]
fn need_backtrack() {
    let input: Array<Domino> = array![(1, 2), (2, 3), (3, 1), (2, 4), (2, 4)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn separate_loops() {
    let input: Array<Domino> = array![(1, 2), (2, 3), (3, 1), (1, 1), (2, 2), (3, 3)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn pop_same_value_first() {
    let input: Array<Domino> = array![(2, 3), (3, 1), (1, 1), (2, 2), (3, 3), (2, 1)];
    assert_correct(@input);
}

#[test]
#[ignore]
fn nine_elements() {
    let input: Array<Domino> = array![
        (1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6),
    ];
    assert_correct(@input);
}

#[test]
#[ignore]
fn separate_three_domino_loops() {
    let input: Array<Domino> = array![(1, 2), (2, 3), (3, 1), (4, 5), (5, 6), (6, 4)];
    let none: Option<Array<Domino>> = Option::None;
    assert_eq!(chain(@input), none);
}
