use alexandria_math::gcd_of_n_numbers::gcd_two_numbers;
use alexandria_math::fast_power::fast_power;
use alexandria_math::fast_root::fast_nr_optimize;
use core::fmt::{Debug, Formatter, Error};

#[derive(Drop, Debug, Copy)]
struct Rational {
    numer: i128,
    denom: i128,
}

#[generate_trait]
impl RationalImpl of RationalTrait {
    fn new(numer: i128, denom: i128) -> Rational {
        assert!(denom != 0, "denominator cannot be 0");

        let numer_sign: i128 = if (numer < 0 && denom > 0) || (numer > 0 && denom < 0) {
            -1
        } else {
            1
        };

        let numer_abs = abs(numer);
        let denom_abs = abs(denom);
        let gcd_num = gcd_two_numbers(numer_abs, denom_abs);

        let mut numer_minif = to_i128(numer_abs / gcd_num) * numer_sign;
        let denom_minif = to_i128(denom_abs / gcd_num);

        Rational { numer: numer_minif, denom: denom_minif }
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
        RationalTrait::new(a.numer * -1, a.denom)
    }
}

impl RationalAdd of Add<Rational> {
    fn add(lhs: Rational, rhs: Rational) -> Rational {
        let numer = (lhs.numer * rhs.denom) + (lhs.denom * rhs.numer);
        let denom = lhs.denom * rhs.denom;
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
        RationalTrait::new(lhs.numer * rhs.numer, lhs.denom * rhs.denom)
    }
}

impl RationalDiv of Div<Rational> {
    fn div(lhs: Rational, rhs: Rational) -> Rational {
        RationalTrait::new(lhs.numer * rhs.denom, lhs.denom * rhs.numer)
    }
}

#[generate_trait]
impl RationalAbs of RationalAbsTrait {
    fn abs(self: @Rational) -> Rational {
        RationalTrait::new(to_i128(abs(*self.numer)), *self.denom)
    }
}

#[generate_trait]
impl RationalPow of RationalPowTrait {
    fn pow(self: @Rational, power: i128) -> Rational {
        if *self.numer == 0 {
            return *self;
        };
        // fast_power works only with unsigned integers
        let power_abs = abs(power);
        let numer = abs(*self.numer);
        let denom = to_u128(*self.denom);
        // determine the new number's sign
        let sign: i128 = if *self.numer < 0 && power_abs % 2 == 1 {
            -1
        } else {
            1
        };

        if power < 0 {
            RationalTrait::new(
                sign * to_i128(fast_power(denom, power_abs)), to_i128(fast_power(numer, power_abs))
            )
        } else {
            RationalTrait::new(
                sign * to_i128(fast_power(numer, power_abs)), to_i128(fast_power(denom, power_abs))
            )
        }
    }

    fn rpow(self: @u128, power: Rational) -> u128 {
        // Cairo does not support floating point numbers, so a negative rational number
        // will always return the result 0 (as 1 divided by any number is 0 in Cairo)
        if power.numer < 0 {
            return 0;
        };
        fast_nr_optimize(fast_power(*self, to_u128(power.numer)), to_u128(power.denom), 30)
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

impl I128Debug of Debug<i128> {
    fn fmt(self: @i128, ref f: Formatter) -> Result<(), Error> {
        if *self < 0 {
            f.buffer.append(@"-");
        };
        f.buffer.append(@format!("{}", abs(*self)));
        Result::Ok(())
    }
}

#[cfg(test)]
mod tests;
