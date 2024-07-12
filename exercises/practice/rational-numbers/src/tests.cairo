use core::traits::TryInto;
use core::fmt::{Debug, Formatter, Error};
use rational_numbers::{RationalTrait as Rational, RationalAbsTrait, RationalPowTrait};

// Enables printing i128 values in tests.
// Note that this will soon be added to the core library.
impl I128Debug of Debug<i128> {
    fn fmt(self: @i128, ref f: Formatter) -> Result<(), Error> {
        if *self < 0 {
            f.buffer.append(@"-");
        };
        let abs_value = if *self < 0 {
            *self * -1
        } else {
            *self
        };
        let abs_value: u32 = abs_value.try_into().unwrap();
        f.buffer.append(@format!("{}", abs_value));
        Result::Ok(())
    }
}

// Tests of type: Arithmetic

// Addition

#[test]
fn add_two_positive_rational_numbers() {
    assert_eq!(Rational::new(1, 2) + Rational::new(2, 3), Rational::new(7, 6));
}

#[test]
fn add_a_positive_rational_number_and_a_negative_rational_number() {
    assert_eq!(Rational::new(1, 2) + Rational::new(-2, 3), Rational::new(-1, 6));
}

#[test]
fn add_two_negative_rational_numbers() {
    assert_eq!(Rational::new(-1, 2) + Rational::new(-2, 3), Rational::new(-7, 6));
}

#[test]
fn add_a_rational_number_to_its_additive_inverse() {
    assert_eq!(Rational::new(1, 2) + Rational::new(-1, 2), Rational::new(0, 1));
}

// Subtraction

#[test]
fn subtract_two_positive_rational_numbers() {
    assert_eq!(Rational::new(1, 2) - Rational::new(2, 3), Rational::new(-1, 6));
}

#[test]
fn subtract_a_positive_rational_number_and_a_negative_rational_number() {
    assert_eq!(Rational::new(1, 2) - Rational::new(-2, 3), Rational::new(7, 6));
}

#[test]
fn subtract_two_negative_rational_numbers() {
    assert_eq!(Rational::new(-1, 2) - Rational::new(-2, 3), Rational::new(1, 6));
}

#[test]
fn subtract_a_rational_number_from_itself() {
    assert_eq!(Rational::new(1, 2) - Rational::new(1, 2), Rational::new(0, 1));
}

// Multiplication

#[test]
fn multiply_two_positive_rational_numbers() {
    assert_eq!(Rational::new(1, 2) * Rational::new(2, 3), Rational::new(1, 3));
}

#[test]
fn multiply_a_negative_rational_number_by_a_positive_rational_number() {
    assert_eq!(Rational::new(-1, 2) * Rational::new(2, 3), Rational::new(-1, 3));
}

#[test]
fn multiply_two_negative_rational_numbers() {
    assert_eq!(Rational::new(-1, 2) * Rational::new(-2, 3), Rational::new(1, 3));
}

#[test]
fn multiply_a_rational_number_by_its_reciprocal() {
    assert_eq!(Rational::new(1, 2) * Rational::new(2, 1), Rational::new(1, 1));
}

#[test]
fn multiply_a_rational_number_by_1() {
    assert_eq!(Rational::new(1, 2) * Rational::new(1, 1), Rational::new(1, 2));
}

#[test]
fn multiply_a_rational_number_by_0() {
    assert_eq!(Rational::new(1, 2) * Rational::new(0, 1), Rational::new(0, 1));
}

// Division

#[test]
fn divide_two_positive_rational_numbers() {
    assert_eq!(Rational::new(1, 2) / Rational::new(2, 3), Rational::new(3, 4));
}

#[test]
fn divide_a_positive_rational_number_by_a_negative_rational_number() {
    assert_eq!(Rational::new(1, 2) / Rational::new(-2, 3), Rational::new(-3, 4));
}

#[test]
fn divide_two_negative_rational_numbers() {
    assert_eq!(Rational::new(-1, 2) / Rational::new(-2, 3), Rational::new(3, 4));
}

#[test]
fn divide_a_rational_number_by_1() {
    assert_eq!(Rational::new(1, 2) / Rational::new(1, 1), Rational::new(1, 2));
}

// Tests of type: Absolute value

#[test]
fn absolute_value_of_a_positive_rational_number() {
    assert_eq!(Rational::new(1, 2).abs(), Rational::new(1, 2));
}

#[test]
fn absolute_value_of_a_positive_rational_number_with_negative_numerator_and_denominator() {
    assert_eq!(Rational::new(-1, -2).abs(), Rational::new(1, 2));
}

#[test]
fn absolute_value_of_a_negative_rational_number() {
    assert_eq!(Rational::new(-1, 2).abs(), Rational::new(1, 2));
}

#[test]
fn absolute_value_of_a_negative_rational_number_with_negative_denominator() {
    assert_eq!(Rational::new(1, -2).abs(), Rational::new(1, 2));
}

#[test]
fn absolute_value_of_zero() {
    assert_eq!(Rational::new(0, 1).abs(), Rational::new(0, 1));
}

#[test]
fn absolute_value_of_a_rational_number_is_reduced_to_lowest_terms() {
    assert_eq!(Rational::new(2, 4).abs(), Rational::new(1, 2));
}

// Tests of type: Exponentiation of a rational number

#[test]
fn raise_a_positive_rational_number_to_a_positive_integer_power() {
    assert_eq!(Rational::new(1, 2).pow(3), Rational::new(1, 8));
}

#[test]
fn raise_a_negative_rational_number_to_a_positive_integer_power() {
    assert_eq!(Rational::new(-1, 2).pow(3), Rational::new(-1, 8));
}

#[test]
fn raise_a_positive_rational_number_to_a_negative_integer_power() {
    assert_eq!(Rational::new(3, 5).pow(-2), Rational::new(25, 9));
}

#[test]
fn raise_a_negative_rational_number_to_an_even_negative_integer_power() {
    assert_eq!(Rational::new(-3, 5).pow(-2), Rational::new(25, 9));
}

#[test]
fn raise_a_negative_rational_number_to_an_odd_negative_integer_power() {
    assert_eq!(Rational::new(-3, 5).pow(-3), Rational::new(-125, 27));
}

#[test]
fn raise_zero_to_an_integer_power() {
    assert_eq!(Rational::new(0, 1).pow(5), Rational::new(0, 1));
}

#[test]
fn raise_one_to_an_integer_power() {
    assert_eq!(Rational::new(1, 1).pow(4), Rational::new(1, 1));
}

#[test]
fn raise_a_positive_rational_number_to_the_power_of_zero() {
    assert_eq!(Rational::new(1, 2).pow(0), Rational::new(1, 1));
}

#[test]
fn raise_a_negative_rational_number_to_the_power_of_zero() {
    assert_eq!(Rational::new(-1, 2).pow(0), Rational::new(1, 1));
}

// Tests of type: Exponentiation of a real number to a rational number

#[test]
fn raise_a_real_number_to_a_positive_rational_number() {
    assert_eq!(8_u128.rpow(Rational::new(4, 3)), 16);
}

#[test]
fn raise_a_real_number_to_a_negative_rational_number() {
    assert_eq!(9_u128.rpow(Rational::new(-1, 2)), 0);
}

#[test]
fn raise_a_real_number_to_a_zero_rational_number() {
    assert_eq!(2_u128.rpow(Rational::new(0, 1)), 1);
}

// Tests of type: Reduction to lowest terms

#[test]
fn reduce_a_positive_rational_number_to_lowest_terms() {
    assert_eq!(Rational::new(2, 4), Rational::new(1, 2));
}

#[test]
fn reduce_places_the_minus_sign_on_the_numerator() {
    assert_eq!(Rational::new(3, -4), Rational::new(-3, 4));
}

#[test]
fn reduce_a_negative_rational_number_to_lowest_terms() {
    assert_eq!(Rational::new(-4, 6), Rational::new(-2, 3));
}

#[test]
fn reduce_a_rational_number_with_a_negative_denominator_to_lowest_terms() {
    assert_eq!(Rational::new(3, -9), Rational::new(-1, 3));
}

#[test]
fn reduce_zero_to_lowest_terms() {
    assert_eq!(Rational::new(0, 6), Rational::new(0, 1));
}

#[test]
fn reduce_an_integer_to_lowest_terms() {
    assert_eq!(Rational::new(-14, 7), Rational::new(-2, 1));
}

#[test]
fn reduce_one_to_lowest_terms() {
    assert_eq!(Rational::new(13, 13), Rational::new(1, 1));
}
