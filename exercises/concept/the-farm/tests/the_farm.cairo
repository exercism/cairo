    use super::*;

    const PRECISION: f64 = 1e-5;

    // Define test fodder calculator struct
    struct TestFodderCalculator {
        amount: f64,
        amount_err: Option<String>,
        factor: f64,
        factor_err: Option<String>,
    }

    impl FodderCalculator for TestFodderCalculator {
        fn fodder_amount(&self, _cows: u32) -> Result<f64, String> {
            match &self.amount_err {
                Some(err) => Err(err.clone()),
                None => Ok(self.amount),
            }
        }

        fn fattening_factor(&self) -> Result<f64, String> {
            match &self.factor_err {
                Some(err) => Err(err.clone()),
                None => Ok(self.factor),
            }
        }
    }

    #[test]
    fn test_divide_food() {
        let tests = vec![
            (
                "success, simple inputs",
                TestFodderCalculator { amount: 100.0, amount_err: None, factor: 1.0, factor_err: None },
                10,
                Ok(10.0),
            ),
            (
                "success, decimal inputs",
                TestFodderCalculator { amount: 60.5, amount_err: None, factor: 1.3, factor_err: None },
                5,
                Ok(15.73),
            ),
            (
                "error when retrieving fodder amount",
                TestFodderCalculator { amount: 0.0, amount_err: Some("amount could not be determined".into()), factor: 1.0, factor_err: None },
                10,
                Err("amount could not be determined".to_string()),
            ),
            (
                "error when retrieving fattening factor",
                TestFodderCalculator { amount: 100.0, amount_err: None, factor: 0.0, factor_err: Some("factor could not be determined".into()) },
                10,
                Err("factor could not be determined".to_string()),
            ),
        ];

        for (name, calculator, cows, expected) in tests {
            let result = divide_food(&calculator, cows);

            match (result, expected) {
                (Ok(amount), Ok(exp_amount)) => {
                    assert!((amount - exp_amount).abs() < PRECISION, "{}: Expected {} but got {}", name, exp_amount, amount);
                },
                (Err(err), Err(exp_err)) => {
                    assert_eq!(err, exp_err, "{}: Expected error {} but got {}", name, exp_err, err);
                },
                _ => panic!("{}: Unexpected result: {:?}", name, result),
            }
        }
    }

    #[test]
    fn test_validate_input_and_divide_food() {
        let tests = vec![
            (
                "negative cows are invalid",
                TestFodderCalculator { amount: 10.0, amount_err: None, factor: 1.0, factor_err: None },
                -10,
                Err("invalid number of cows".to_string()),
            ),
            (
                "zero cows are invalid",
                TestFodderCalculator { amount: 10.0, amount_err: None, factor: 1.0, factor_err: None },
                0,
                Err("invalid number of cows".to_string()),
            ),
            (
                "success, simple inputs",
                TestFodderCalculator { amount: 100.0, amount_err: None, factor: 1.0, factor_err: None },
                10,
                Ok(10.0),
            ),
            (
                "success, decimal inputs",
                TestFodderCalculator { amount: 60.5, amount_err: None, factor: 1.3, factor_err: None },
                5,
                Ok(15.73),
            ),
        ];

        for (name, calculator, cows, expected) in tests {
            let result = validate_input_and_divide_food(&calculator, cows as u32);

            match (result, expected) {
                (Ok(amount), Ok(exp_amount)) => {
                    assert!((amount - exp_amount).abs() < PRECISION, "{}: Expected {} but got {}", name, exp_amount, amount);
                },
                (Err(err), Err(exp_err)) => {
                    assert_eq!(err, exp_err, "{}: Expected error {} but got {}", name, exp_err, err);
                },
                _ => panic!("{}: Unexpected result: {:?}", name, result),
            }
        }
    }

    #[test]
    fn test_validate_number_of_cows() {
        let tests = vec![
            ("big positive number of cows", 80, None),
            ("small positive number of cows", 2, None),
            ("big negative number of cows", -20, Some("-20 cows are invalid: there are no negative cows".to_string())),
            ("small negative number of cows", -1, Some("-1 cows are invalid: there are no negative cows".to_string())),
            ("zero cows", 0, Some("0 cows are invalid: no cows don't need food".to_string())),
        ];

        for (name, cows, expected_err) in tests {
            let result = validate_number_of_cows(cows);

            match (result, expected_err) {
                (Ok(_), None) => (),
                (Err(err), Some(exp_err)) => assert_eq!(err.to_string(), exp_err, "{}: Expected error {} but got {}", name, exp_err, err),
                _ => panic!("{}: Unexpected result: {:?}", name, result),
            }
        }
    }

    #[test]
    fn test_validate_number_of_cows_pointer_returned() {
        let err = validate_number_of_cows(-10).err();
        assert!(matches!(err, Some(_)), "Expected Some error but got {:?}", err);
    }
    