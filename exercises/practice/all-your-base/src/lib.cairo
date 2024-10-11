#[derive(Drop, Debug, PartialEq)]
enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit: u32,
}


///
/// Convert a number between two bases.
///
/// A number is any array of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return the corresponding Error enum if the conversion is impossible.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: array![4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Result::Ok([1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty array ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///    However, your function must be able to process input with leading 0 digits.
///
pub fn convert(number: Array<u32>, from_base: u32, to_base: u32) -> Result<Array<u32>, Error> {
    panic!("implement `convert`")
}