use alexandria_math::gcd_of_n_numbers::gcd_two_numbers;
use alexandria_math::fast_power::fast_power;
use alexandria_math::fast_root::fast_nr_optimize;
use core::fmt::{Debug, Formatter, Error};

#[derive(Drop, Debug, Copy)]
struct Rational {
    numer: i128,
    denom: u128,
}

#[generate_trait]
impl RationalImpl of RationalTrait {
    fn new(numer: i128, denom: i128) -> Rational {
        assert!(denom != 0, "denominator cannot be 0");

        let sign: i128 = if (numer < 0 && denom > 0) || (numer > 0 && denom < 0) {
            -1
        } else {
            1
        };

        let numer = abs(numer);
        let denom = abs(denom);
        let gcd_num = gcd_two_numbers(numer, denom);

        let numer = to_i128(numer / gcd_num) * sign;
        let denom = denom / gcd_num;

        Rational { numer, denom }
    }
}

impl RationalPartialEq of PartialEq<Rational> {
    fn eq(lhs: @Rational, rhs: @Rational) -> bool {
        lhs.numer == rhs.numer && lhs.denom == rhs.denom
    }

    fn ne(lhs: @Rational, rhs: @Rational) -> bool {
        !(lhs == rhs)
    }
}

impl RationalNeg of Neg<Rational> {
    fn neg(a: Rational) -> Rational {
        RationalTrait::new(a.numer * -1, to_i128(a.denom))
    }
}

impl RationalAdd of Add<Rational> {
    fn add(lhs: Rational, rhs: Rational) -> Rational {
        let numer = (lhs.numer * to_i128(rhs.denom)) + (to_i128(lhs.denom) * rhs.numer);
        let denom = to_i128(lhs.denom * rhs.denom);
        RationalTrait::new(numer, denom)
    }
}

impl RationalSub of Sub<Rational> {
    fn sub(lhs: Rational, rhs: Rational) -> Rational {
        lhs + (-rhs)
    }
}

impl RationalMul of Mul<Rational> {
    fn mul(lhs: Rational, rhs: Rational) -> Rational {
        RationalTrait::new(lhs.numer * rhs.numer, to_i128(lhs.denom * rhs.denom))
    }
}

impl RationalDiv of Div<Rational> {
    fn div(lhs: Rational, rhs: Rational) -> Rational {
        RationalTrait::new(lhs.numer * to_i128(rhs.denom), to_i128(lhs.denom) * rhs.numer)
    }
}

#[generate_trait]
impl RationalAbs of RationalAbsTrait {
    fn abs(self: @Rational) -> Rational {
        RationalTrait::new(to_i128(abs(*self.numer)), to_i128(*self.denom))
    }
}

#[generate_trait]
impl RationalPow of RationalPowTrait {
    fn pow(self: @Rational, power: i128) -> Rational {
        if *self.numer == 0 {
            return *self;
        };

        let power_abs = abs(power);

        // determine the new number's sign
        let sign: i128 = if *self.numer < 0 && power_abs % 2 == 1 {
            -1
        } else {
            1
        };

        let numer = to_i128(fast_power(abs(*self.numer), power_abs)) * sign;
        let denom = to_i128(fast_power(*self.denom, power_abs));

        if power < 0 {
            RationalTrait::new(denom, numer)
        } else {
            RationalTrait::new(numer, denom)
        }
    }

    fn rpow(self: @u128, power: Rational) -> u128 {
        // Cairo only supports integers, so a negative rational exponent
        // will always return the result 0
        if power.numer < 0 {
            return 0;
        };
        fast_nr_optimize(fast_power(*self, to_u128(power.numer)), power.denom, 30)
    }
}

// Enables printing i128 values in tests.
// Note that this will soon be added to the core library.
impl I128Debug of Debug<i128> {
    fn fmt(self: @i128, ref f: Formatter) -> Result<(), Error> {
        if *self < 0 {
            f.buffer.append(@"-");
        };
        f.buffer.append(@format!("{}", abs(*self)));
        Result::Ok(())
    }
}

fn abs(n: i128) -> u128 {
    let val = if n < 0 {
        n * -1
    } else {
        n
    };
    to_u128(val)
}

fn to_i128(n: u128) -> i128 {
    n.try_into().unwrap()
}

fn to_u128(n: i128) -> u128 {
    n.try_into().unwrap()
}

#[cfg(test)]
mod tests;
