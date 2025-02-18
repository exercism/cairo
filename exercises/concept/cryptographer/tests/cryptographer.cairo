mod add_messages_tests {
    use cryptographer::add_messages;

    #[test]
    fn positive_numbers() {
        assert_eq!(add_messages(5, 3), 8);
        assert_eq!(add_messages(1000, 2000), 3000);
        assert_eq!(add_messages(1, 1), 2);
    }

    #[test]
    #[ignore]
    fn zero() {
        assert_eq!(add_messages(0, 0), 0);
        assert_eq!(add_messages(5, 0), 5);
        assert_eq!(add_messages(0, 5), 5);
    }

    #[test]
    #[ignore]
    fn large_numbers() {
        // Testing with numbers close to field limits
        let large_num1 = 0x400000000000000000000000000000000000000000000000000000000000000;
        let large_num2 = 0x400000000000000000000000000000000000000000000000000000000000000;
        assert_eq!(
            add_messages(large_num1, large_num2),
            0x800000000000000000000000000000000000000000000000000000000000000,
        );
    }

    #[test]
    #[ignore]
    fn wrapping_to_zero() {
        let message1 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
        let message2 = 1;
        assert_eq!(0, add_messages(message1, message2));
    }

    #[test]
    #[ignore]
    fn wrapping_to_large_number() {
        let message1 = 3618502788666131213697322783095070105623107215331596699973092056135007822949;
        let message2 = 987654321;
        assert_eq!(123456789, add_messages(message1, message2));
    }
}

mod subtract_messages_tests {
    use cryptographer::subtract_messages;

    #[test]
    #[ignore]
    fn positive_numbers() {
        assert_eq!(subtract_messages(5, 3), 2);
        assert_eq!(subtract_messages(1000, 200), 800);
        assert_eq!(subtract_messages(5, 5), 0);
    }

    #[test]
    #[ignore]
    fn zero() {
        assert_eq!(subtract_messages(0, 0), 0);
        assert_eq!(subtract_messages(5, 0), 5);
        assert_eq!(subtract_messages(0, 5), -5);
    }

    #[test]
    #[ignore]
    fn large_numbers() {
        let large_num = 0x400000000000000000000000000000000000000000000000000000000000000;
        assert_eq!(subtract_messages(large_num, large_num), 0);
    }

    #[test]
    #[ignore]
    fn wrapping_to_maximum_felt252_value() {
        let message1 = 0;
        let message2 = 1;
        assert_eq!(
            3618502788666131213697322783095070105623107215331596699973092056135872020480,
            subtract_messages(message1, message2),
        );
    }

    #[test]
    #[ignore]
    fn wrapping_to_large_number() {
        let message1 = 123456789;
        let message2 = 987654321;
        assert_eq!(
            3618502788666131213697322783095070105623107215331596699973092056135007822949,
            subtract_messages(message1, message2),
        );
    }
}


mod multiply_messages_tests {
    use cryptographer::multiply_messages;

    #[test]
    #[ignore]
    fn test_multiply_messages_positive_numbers() {
        assert_eq!(multiply_messages(5, 3), 15);
        assert_eq!(multiply_messages(10, 10), 100);
        assert_eq!(multiply_messages(2, 4), 8);
    }

    #[test]
    #[ignore]
    fn test_multiply_messages_zero() {
        assert_eq!(multiply_messages(0, 0), 0);
        assert_eq!(multiply_messages(5, 0), 0);
        assert_eq!(multiply_messages(0, 5), 0);
    }

    #[test]
    #[ignore]
    fn test_multiply_messages_one() {
        assert_eq!(multiply_messages(1, 5), 5);
        assert_eq!(multiply_messages(5, 1), 5);
        assert_eq!(multiply_messages(1, 1), 1);
    }

    #[test]
    #[ignore]
    fn test_multiply_messages_large_numbers() {
        let large_num1 = 0x200000000000000000000000000000000000000000000000000000000000000;
        let large_num2 = 2;
        assert_eq!(
            multiply_messages(large_num1, large_num2),
            0x400000000000000000000000000000000000000000000000000000000000000,
        );
    }

    #[test]
    #[ignore]
    fn max_felt252() {
        let message1 = 1809251394333065606848661391547535052811553607665798349986546028067936010240;
        let message2 = 2;
        assert_eq!(
            3618502788666131213697322783095070105623107215331596699973092056135872020480,
            multiply_messages(message1, message2),
        );
    }

    #[test]
    #[ignore]
    fn wrapping_to_one() {
        let message1 = 1809251394333065606848661391547535052811553607665798349986546028067936010241;
        let message2 = 2;
        assert_eq!(1, multiply_messages(message1, message2));
    }

    #[test]
    #[ignore]
    fn wrapping_to_large_number() {
        let message1 = 382927772233671078546147897004315551461400594453673204174697055647611;
        let message2 = 9449570;
        assert_eq!(123456789, multiply_messages(message1, message2));
    }
}

mod property_tests {
    use cryptographer::{add_messages, multiply_messages};

    #[test]
    #[ignore]
    fn test_addition_commutative() {
        let a = 123;
        let b = 456;
        assert_eq!(add_messages(a, b), add_messages(b, a));
    }

    #[test]
    #[ignore]
    fn test_addition_associative() {
        let a = 100;
        let b = 200;
        let c = 300;
        assert_eq!(add_messages(add_messages(a, b), c), add_messages(a, add_messages(b, c)));
    }

    #[test]
    #[ignore]
    fn test_multiplication_commutative() {
        let a = 123;
        let b = 456;
        assert_eq!(multiply_messages(a, b), multiply_messages(b, a));
    }

    #[test]
    #[ignore]
    fn test_multiplication_associative() {
        let a = 2;
        let b = 3;
        let c = 4;
        assert_eq!(
            multiply_messages(multiply_messages(a, b), c),
            multiply_messages(a, multiply_messages(b, c)),
        );
    }

    #[test]
    #[ignore]
    fn test_distributive_property() {
        let a = 2;
        let b = 3;
        let c = 4;
        assert_eq!(
            multiply_messages(a, add_messages(b, c)),
            add_messages(multiply_messages(a, b), multiply_messages(a, c)),
        );
    }
}
