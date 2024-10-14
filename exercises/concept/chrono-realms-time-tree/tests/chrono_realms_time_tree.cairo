use chrono_realms_time_tree::{ChronoChain, build_chrono_chain, sum_chain};

#[test]
fn test_build_chrono_chain() {
    let chrono_chain = build_chrono_chain(array![10, 20, 30]);
    // Verify the structure of the chain
    if let ChronoChain::Link((first, next)) = chrono_chain.unbox() {
        assert_eq!(first, 10);

        if let ChronoChain::Link((second, next)) = next.unbox() {
            assert_eq!(second, 20);

            if let ChronoChain::Link((third, next)) = next.unbox() {
                assert_eq!(third, 30);

                if let ChronoChain::Link(_) = next.unbox() {
                    panic!("Expected 4th elements to be ChronoChain::End");
                }
            }
        }
    }
}

#[test]
fn test_sum_chain() {
    let chrono_chain = build_chrono_chain(array![10, 20, 30]);
    let total_sum = sum_chain(@chrono_chain.unbox());
    assert_eq!(total_sum, 60); // 10 + 20 + 30 = 60
}

#[test]
fn test_empty_chain() {
    // Empty chain should sum to 0
    let empty_chain = BoxTrait::new(ChronoChain::End);
    let total_sum = sum_chain(@empty_chain.unbox());
    assert_eq!(total_sum, 0);
}

