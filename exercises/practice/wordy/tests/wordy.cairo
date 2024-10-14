use wordy::answer;

    #[test]
    fn just_a_number() {
        let input = "What is 5?";
        let output = answer(input);
        let expected = (5, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn addition() {
        let input = "What is 1 plus 1?";
        let output = answer(input);
        let expected = (2, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn more_addition() {
        let input = "What is 53 plus 2?";
        let output = answer(input);
        let expected = (55, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn addition_with_negative_numbers() {
        let input = "What is -1 plus -10?";
        let output = answer(input);

        let expected = (-11, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn large_addition() {
        let input = "What is 123 plus 45678?";
        let output = answer(input);

        let expected = (45801, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn subtraction() {
        let input = "What is 4 minus -12?";
        let output = answer(input);

        let expected = (16, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn multiplication() {
        let input = "What is -3 multiplied by 25?";
        let output = answer(input);
        let expected = (-75, true);

        assert_eq!(output, expected);
    }

    #[test]
    fn division() {
        let input = "What is 33 divided by -3?";
        let output = answer(input);

        let expected = (-11, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn multiple_additions() {
        let input = "What is 1 plus 1 plus 1?";
        let output = answer(input);

        let expected = (3, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn addition_and_subtraction() {
        let input = "What is 1 plus 5 minus -2?";
        let output = answer(input);

        let expected = (8, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn multiple_subtraction() {
        let input = "What is 20 minus 4 minus 13?";
        let output = answer(input);

        let expected = (3, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn subtraction_then_addition() {
        let input = "What is 17 minus 6 plus 3?";
        let output = answer(input);

        let expected = (14, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn multiple_multiplication() {
        let input = "What is 2 multiplied by -2 multiplied by 3?";
        let output = answer(input);
        let expected = (-12, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn addition_and_multiplication() {
        let input = "What is -3 plus 7 multiplied by -2?";
        let output = answer(input);

        let expected = (-8, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn multiple_division() {
        let input = "What is -12 divided by 2 divided by -3?";
        let output = answer(input);

        let expected = (2, true);
        assert_eq!(output, expected);
    }

    #[test]
    fn unknown_operation() {
        let input = "What is 52 cubed?";
        let output = answer(input);

        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn non_math_question() {
        let input = "Who is the President of the United States?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_problem_missing_an_operand() {
        let input = "What is 1 plus?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_problem_with_no_operands_or_operators() {
        let input = "What is?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_two_operations_in_a_row() {
        let input = "What is 1 plus plus 2?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_two_numbers_in_a_row() {
        let input = "What is 1 plus 2 1?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_postfix_notation() {
        let input = "What is 1 2 plus?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }

    #[test]
    fn reject_prefix_notation() {
        let input = "What is plus 1 2?";
        let output = answer(input);
        let expected = (0, false);
        assert_eq!(output, expected);
    }
