use chrono_realms_time_tree::{ChronoChainTrait, ChronoChain};

const U32_MAX: u32 = 0xFFFFFFFF;

// Test for building a ChronoChain from an empty array
#[test]
fn test_empty_array() {
    let chrono_chain = ChronoChainTrait::build(array![]);

    // The resulting chain should only contain "End"
    match chrono_chain {
        ChronoChain::End => (),
        _ => panic!("Expected ChronoChain to be End for an empty array"),
    }
}

// Test for building a ChronoChain from a single element
#[test]
fn test_single_element_array() {
    let chrono_chain = ChronoChainTrait::build(array![42]);

    // The first link should have value 42, and the next should be "End"
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

// Test for building a ChronoChain from multiple elements
#[test]
fn test_multiple_elements_array() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3]);

    // The first link should have value 1, the second should have value 2, and the last should be
    // "End"
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

// Test for building a ChronoChain with duplicate values
#[test]
fn test_duplicate_values_array() {
    let chrono_chain = ChronoChainTrait::build(array![5, 5, 5]);

    // The chain should contain three links, all with value 5
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


// Test for building a ChronoChain from large values
#[test]
fn test_large_values_array() {
    let chrono_chain = ChronoChainTrait::build(array![U32_MAX, U32_MAX]);

    // The first link should have value U32_MAX, and the second should also have value U32_MAX,
    // followed by "End"
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

// Test for building a ChronoChain from a large array of values
#[test]
fn test_large_array() {
    let mut chrono_chain = ChronoChainTrait::build(array_in_range((1..1000)));

    // The sum of numbers 1 + 2 + ... + 999 is 999 * (999 + 1) / 2 = 499500
    let mut count = 1;
    while let ChronoChain::Link((value, next)) = chrono_chain {
        assert_eq!(value, count);
        count += 1;
        chrono_chain = next.unbox();
    };

    // Verify the chrono_chain ends correctly
    match chrono_chain {
        ChronoChain::End => (),
        _ => panic!("Expected ChronoChain to be End at the end of the chain"),
    }
}

// Test for summing the values in a ChronoChain
#[test]
fn test_sum_chain() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3]);

    // Test that the sum of values is 6 (1 + 2 + 3)
    let sum = chrono_chain.sum();
    assert_eq!(sum, 6);
}

// Test for an empty ChronoChain (only End)
#[test]
fn test_empty_chain() {
    let chrono_chain = ChronoChainTrait::build(array![]);

    // Test that the sum of an empty chain is 0
    let sum = chrono_chain.sum();
    assert_eq!(sum, 0);
}

// Test for a chain with only one value
#[test]
fn test_single_link_chain() {
    let chrono_chain = ChronoChainTrait::build(array![5]);

    // Test that the sum of the chain with one value is 5
    let sum = chrono_chain.sum();
    assert_eq!(sum, 5);
}

// Test for a chain with two values
#[test]
fn test_two_link_chain() {
    let chrono_chain = ChronoChainTrait::build(array![3, 7]);

    // Test that the sum of the chain with values 3 and 7 is 10 (3 + 7)
    let sum = chrono_chain.sum();
    assert_eq!(sum, 10);
}

// Test for the chain having a large number of elements
#[test]
fn test_large_chain() {
    let chrono_chain = ChronoChainTrait::build(array![1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

    // The sum of 1 to 10 is 55 (1 + 2 + ... + 10)
    let sum = chrono_chain.sum();
    assert_eq!(sum, 55);
}

// Test for chain with large values
#[test]
fn test_large_values_in_chain() {
    let chrono_chain = ChronoChainTrait::build(array![U32_MAX, U32_MAX]);

    // The sum of two `U32_MAX` values should be 2 * U32_MAX
    let expected_sum: u64 = U32_MAX.into() * 2;
    let sum = chrono_chain.sum();
    assert_eq!(sum, expected_sum);
}

// Test for chain with all elements being zero
#[test]
fn test_zero_values_in_chain() {
    let chrono_chain = ChronoChainTrait::build(array![0, 0, 0, 0, 0]);

    // The sum of zeros should be 0
    let sum = chrono_chain.sum();
    assert_eq!(sum, 0);
}

// Test for chain with a very large number of elements
#[test]
fn test_very_large_chain() {
    let chrono_chain = ChronoChainTrait::build(array_in_range((1..1000)));

    // The sum of values 1 + 2 + ... + 999 should be 999 * (999 + 1) / 2 = 499500
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
