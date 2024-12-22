use chrono_realms_chrono_chain::{ChronoChainTrait, ChronoChain};

const U32_MAX: u32 = 0xFFFFFFFF;

#[test]
fn build_empty_array() {
    let chrono_chain = ChronoChainTrait::build(array![]);

    match chrono_chain {
        ChronoChain::End => (),
        _ => panic!("Expected ChronoChain to be End for an empty array"),
    }
}

#[test]
#[ignore]
fn build_single_element_array() {
    let chrono_chain = ChronoChainTrait::build(array![42]);

    match chrono_chain {
        ChronoChain::Link((
            value, next,
        )) => {
            assert_eq!(value, 42);
            match next.unbox() {
                ChronoChain::End => (),
                _ => panic!("Expected next to be End"),
            }
        },
        _ => panic!("Expected ChronoChain to be Link for a single element array"),
    }
}

#[test]
#[ignore]
fn build_multiple_elements_array() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3]);

    match chrono_chain {
        ChronoChain::Link((
            value, next,
        )) => {
            assert_eq!(value, 1);
            match next.unbox() {
                ChronoChain::Link((
                    value, next,
                )) => {
                    assert_eq!(value, 2);
                    match next.unbox() {
                        ChronoChain::Link((
                            value, next,
                        )) => {
                            assert_eq!(value, 3);
                            match next.unbox() {
                                ChronoChain::End => (),
                                _ => panic!("Expected next to be End after the last link"),
                            }
                        },
                        _ => panic!("Expected second link to be Link"),
                    }
                },
                _ => panic!("Expected third link to be Link"),
            }
        },
        _ => panic!("Expected ChronoChain to be Link for multiple elements"),
    }
}

#[test]
#[ignore]
fn build_duplicate_values_array() {
    let chrono_chain = ChronoChainTrait::build(array![5, 5, 5]);

    match chrono_chain {
        ChronoChain::Link((
            value, next,
        )) => {
            assert_eq!(value, 5);
            match next.unbox() {
                ChronoChain::Link((
                    value, next,
                )) => {
                    assert_eq!(value, 5);
                    match next.unbox() {
                        ChronoChain::Link((
                            value, next,
                        )) => {
                            assert_eq!(value, 5);
                            match next.unbox() {
                                ChronoChain::End => (),
                                _ => panic!("Expected next to be End after the last link"),
                            }
                        },
                        _ => panic!("Expected third link to be Link"),
                    }
                },
                _ => panic!("Expected second link to be Link"),
            }
        },
        _ => panic!("Expected ChronoChain to be Link for duplicate values"),
    }
}


#[test]
#[ignore]
fn build_large_values_array() {
    let chrono_chain = ChronoChainTrait::build(array![U32_MAX, U32_MAX]);

    match chrono_chain {
        ChronoChain::Link((
            value, next,
        )) => {
            assert_eq!(value, U32_MAX);
            match next.unbox() {
                ChronoChain::Link((
                    value, next,
                )) => {
                    assert_eq!(value, U32_MAX);
                    match next.unbox() {
                        ChronoChain::End => (),
                        _ => panic!("Expected next to be End after the last link"),
                    }
                },
                _ => panic!("Expected second link to be Link"),
            }
        },
        _ => panic!("Expected ChronoChain to be Link for large values"),
    }
}

#[test]
#[ignore]
fn build_large_array() {
    let mut chrono_chain = ChronoChainTrait::build(array_in_range((1..1000)));

    let mut count = 1;
    while let ChronoChain::Link((value, next)) = chrono_chain {
        assert_eq!(value, count);
        count += 1;
        chrono_chain = next.unbox();
    };

    match chrono_chain {
        ChronoChain::End => (),
        _ => panic!("Expected ChronoChain to be End at the end of the chain"),
    }
}

#[test]
#[ignore]
fn sum_chain() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 6);
}

#[test]
#[ignore]
fn sum_empty_chain() {
    let chrono_chain = ChronoChainTrait::build(array![]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 0);
}

#[test]
#[ignore]
fn sum_single_link_chain() {
    let chrono_chain = ChronoChainTrait::build(array![5]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 5);
}

#[test]
#[ignore]
fn sum_two_link_chain() {
    let chrono_chain = ChronoChainTrait::build(array![3, 7]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 10);
}

#[test]
#[ignore]
fn sum_large_chain() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 55);
}

#[test]
#[ignore]
fn sum_large_values_in_chain() {
    let chrono_chain = ChronoChainTrait::build(array![U32_MAX, U32_MAX]);

    let expected_sum: u64 = U32_MAX.into() * 2;
    let sum = chrono_chain.sum();
    assert_eq!(sum, expected_sum);
}

#[test]
#[ignore]
fn sum_zero_values_in_chain() {
    let chrono_chain = ChronoChainTrait::build(array![0, 0, 0, 0, 0]);

    let sum = chrono_chain.sum();
    assert_eq!(sum, 0);
}

#[test]
#[ignore]
fn sum_very_large_chain() {
    let chrono_chain = ChronoChainTrait::build(array_in_range((1..1000)));

    let expected_sum = 999 * (999 + 1) / 2;
    let sum = chrono_chain.sum();
    assert_eq!(sum, expected_sum);
}

fn array_in_range(range: core::ops::Range<u32>) -> Array<u32> {
    let mut arr = array![];
    for elem in range {
        arr.append(elem);
    };
    arr
}
