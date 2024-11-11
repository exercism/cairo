use calculator_conundrum::SimpleCalculatorTrait as SimpleCalculator;

#[test]
fn addition_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(22, 25, Option::Some('+')).unwrap(), "22 + 25 = 47");
}

#[test]
fn addition_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(378_961, 399_635, Option::Some('+')).unwrap(),
        "378961 + 399635 = 778596"
    );
}

#[test]
fn multiplication_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(3, 21, Option::Some('*')).unwrap(), "3 * 21 = 63");
}

#[test]
fn multiplication_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(72_441, 2_048, Option::Some('*')).unwrap(),
        "72441 * 2048 = 148359168"
    );
}

#[test]
fn division_with_small_operands() {
    assert_eq!(SimpleCalculator::calculate(72, 9, Option::Some('/')).unwrap(), "72 / 9 = 8");
}

#[test]
fn division_with_large_operands() {
    assert_eq!(
        SimpleCalculator::calculate(1_338_800, 83_675, Option::Some('/')).unwrap(),
        "1338800 / 83675 = 16"
    );
}

#[test]
fn calculate_throws_exception_for_non_valid_operations() {
    assert_eq!(
        SimpleCalculator::calculate(1, 2, Option::Some('**')).unwrap_err(),
        "Operation is out of range"
    );
}

#[test]
fn calculate_throws_exception_for_null_as_operation() {
    assert_eq!(
        SimpleCalculator::calculate(1, 2, Option::None).unwrap_err(), "Operation cannot be null"
    );
}

#[test]
fn calculate_throws_exception_for_empty_string_as_operation() {
    assert_eq!(
        SimpleCalculator::calculate(1, 2, Option::Some('')).unwrap_err(),
        "Operation cannot be an empty string"
    );
}

#[test]
fn calculate_throws_exception_for_division_with_0() {
    assert_eq!(
        SimpleCalculator::calculate(33, 0, Option::Some('/')).unwrap_err(),
        "Division by zero is not allowed"
    );
}
