use core::fmt::{Display, Error, Formatter};

// Define custom error types
#[derive(Debug, PartialEq)]
enum CalculatorError {
    OutOfRangeOperation,
    NullOperation,
    EmptyOperation,
    DivisionByZero,
}

impl CalculatorErrorDisplay of Display<CalculatorError> {
    fn fmt(self: CalculatorError, f: Formatter) -> Result<(), Error> {
        match self {
            CalculatorError::OutOfRangeOperation => write!(f, "Operation is out of range."),
            CalculatorError::NullOperation => write!(f, "Operation cannot be null."),
            CalculatorError::EmptyOperation => write!(f, "Operation cannot be an empty string."),
            CalculatorError::DivisionByZero => write!(f, "Division by zero is not allowed."),
        }
    }
}

impl Error for CalculatorError {}

// The SimpleCalculator module or struct
struct SimpleCalculator;

impl SimpleCalculator {
    fn calculate(a: i32, b: i32, operation: Option<&str>) -> Result<String, CalculatorError> {
        match operation {
            Some("+") => Ok(format!("{} + {} = {}", a, b, a + b)),
            Some("*") => Ok(format!("{} * {} = {}", a, b, a * b)),
            Some("/") => {
                if b == 0 {
                    Err(CalculatorError::DivisionByZero)
                } else {
                    Ok(format!("{} / {} = {}", a, b, a / b))
                }
            }
            Some("") => Err(CalculatorError::EmptyOperation),
            Some(_) => Err(CalculatorError::OutOfRangeOperation),
            None => Err(CalculatorError::NullOperation),
        }
    }
}

// Unit tests
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn addition_with_small_operands() {
        assert_eq!(SimpleCalculator::calculate(22, 25, Some("+")).unwrap(), "22 + 25 = 47");
    }

    #[test]
    fn addition_with_large_operands() {
        assert_eq!(SimpleCalculator::calculate(378_961, 399_635, Some("+")).unwrap(), "378961 + 399635 = 778596");
    }

    #[test]
    fn multiplication_with_small_operands() {
        assert_eq!(SimpleCalculator::calculate(3, 21, Some("*")).unwrap(), "3 * 21 = 63");
    }

    #[test]
    fn multiplication_with_large_operands() {
        assert_eq!(SimpleCalculator::calculate(72_441, 2_048, Some("*")).unwrap(), "72441 * 2048 = 148359168");
    }

    #[test]
    fn division_with_small_operands() {
        assert_eq!(SimpleCalculator::calculate(72, 9, Some("/")).unwrap(), "72 / 9 = 8");
    }

    #[test]
    fn division_with_large_operands() {
        assert_eq!(SimpleCalculator::calculate(1_338_800, 83_675, Some("/")).unwrap(), "1338800 / 83675 = 16");
    }

    #[test]
    fn calculate_throws_exception_for_non_valid_operations() {
        assert_eq!(SimpleCalculator::calculate(1, 2, Some("**")).unwrap_err(), CalculatorError::OutOfRangeOperation);
    }

    #[test]
    fn calculate_throws_exception_for_null_as_operation() {
        assert_eq!(SimpleCalculator::calculate(1, 2, None).unwrap_err(), CalculatorError::NullOperation);
    }

    #[test]
    fn calculate_throws_exception_for_empty_string_as_operation() {
        assert_eq!(SimpleCalculator::calculate(1, 2, Some("")).unwrap_err(), CalculatorError::EmptyOperation);
    }

    #[test]
    fn calculate_throws_exception_for_division_with_0() {
        assert_eq!(SimpleCalculator::calculate(33, 0, Some("/")).unwrap_err(), CalculatorError::DivisionByZero);
    }
}
