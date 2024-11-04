// Define the FodderCalculator trait with methods FodderAmount and FatteningFactor
trait FodderCalculator<T> {
    fn fodder_amount(self: @T, cows: u32) -> Result<u64, ByteArray>;
    fn fattening_factor(self: @T) -> Result<u64, ByteArray>;
}

// Implements the DivideFood function, which divides fodder per cow
fn divide_food<T, +FodderCalculator<T>>(calculator: @T, cows: u32) -> Result<u64, ByteArray> {
    let fodder = calculator.fodder_amount(cows)?;
    let factor = calculator.fattening_factor()?;
    let amount_per_cow = fodder / cows.into() * factor;
    Result::Ok(amount_per_cow)
}

// Implement validation for positive cow count, and if valid, call divide_food
fn validate_input_and_divide_food<T, +FodderCalculator<T>>(
    calculator: @T, cows: u32,
) -> Result<u64, ByteArray> {
    if cows <= 0 {
        Result::Err("invalid number of cows")
    } else {
        divide_food(calculator, cows)
    }
}

// Custom error type for invalid cow input
#[derive(Debug)]
struct InvalidCowsError {
    cows: i32,
    message: ByteArray,
}

use core::fmt::{Display, Formatter, Error};

impl DisplayInvalidCowsError of Display<InvalidCowsError> {
    fn fmt(self: @InvalidCowsError, ref f: Formatter) -> Result<(), Error> {
        write!(f, "{} cows are invalid: {}", self.cows, self.message)
    }
}

// Function to validate the number of cows, returning an InvalidCowsError for invalid input
fn validate_number_of_cows(cows: i32) -> Result<(), InvalidCowsError> {
    if cows < 0 {
        Result::Err(InvalidCowsError { cows, message: "there are no negative cows", })
    } else if cows == 0 {
        Result::Err(InvalidCowsError { cows, message: "no cows don't need food", })
    } else {
        Result::Ok(())
    }
}
