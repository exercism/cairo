use calculator_conundrum::SimpleCalculatorTrait as SimpleCalculator;

#[test]
fn addition_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(22, 25, "+").unwrap(), "22 + 25 = 47");
}

#[test]
#[ignore]
fn addition_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(378_961, 399_635, "+").unwrap(), "378961 + 399635 = 778596"
    );
}

#[test]
#[ignore]
fn multiplication_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(3, 21, "*").unwrap(), "3 * 21 = 63");
}

#[test]
#[ignore]
fn multiplication_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(72_441, 2_048, "*").unwrap(), "72441 * 2048 = 148359168"
    );
}

#[test]
#[ignore]
fn division_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(72, 9, "/").unwrap(), "72 / 9 = 8");
}

#[test]
#[ignore]
fn division_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(1_338_800, 83_675, "/").unwrap(), "1338800 / 83675 = 16"
    );
}

#[test]
#[ignore]
fn calculate_returns_result_err_for_non_valid_operations() {
    assert_eq!(SimpleCalculator::calculate(1, 2, "**").unwrap_err(), "Operation is out of range");
}

#[test]
#[ignore]
#[should_panic(expected: ("Operation cannot be an empty string",))]
fn calculate_returns_result_err_for_empty_string_as_operation() {
    let _ = SimpleCalculator::calculate(1, 2, "");
}

#[test]
#[ignore]
#[should_panic(expected: ('Division by zero is not allowed',))]
fn calculate_panics_for_division_with_0() {
    let _ = SimpleCalculator::calculate(33, 0, "/");
}
