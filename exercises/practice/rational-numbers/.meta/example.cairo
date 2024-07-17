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

        let numer = to_i128(pow(abs(*self.numer), power_abs)) * sign;
        let denom = to_i128(pow(*self.denom, power_abs));

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
        nth_root(pow(*self, to_u128(power.numer)), power.denom)
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

fn pow(base: u128, mut power: u128) -> u128 {
    if base == 0 {
        return base;
    }
    let base: u256 = base.into();
    let mut result = 1_u256;
    while power != 0 {
        result *= base;
        power -= 1;
    };
    result.try_into().expect('too large to fit output type')
}

fn nth_root(m: u128, n: u128) -> u128 {
    // Use linear search on the answer space
    let mut root = 1;
    while root <= m {
        let val = pow(root, n);
        if val >= m {
            break;
        }
        root += 1;
    };
    root
}

fn gcd_two_numbers(mut a: u128, mut b: u128) -> u128 {
    while b != 0 {
        let r = a % b;
        a = b;
        b = r;
    };
    a
}

fn to_i128(n: u128) -> i128 {
    n.try_into().unwrap()
}

fn to_u128(n: i128) -> u128 {
    n.try_into().unwrap()
}

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

#[cfg(test)]
mod tests;
