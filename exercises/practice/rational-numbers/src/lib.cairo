use core::fmt::{Debug, Formatter, Error};

#[derive(Drop, Debug)]
struct Rational {}

#[generate_trait]
pub impl RationalImpl of RationalTrait {
    fn new(numer: i128, denom: i128) -> Rational {
        panic!()
    }
}

impl RationalPartialEq of PartialEq<Rational> {
    fn eq(lhs: @Rational, rhs: @Rational) -> bool {
        panic!()
    }

    fn ne(lhs: @Rational, rhs: @Rational) -> bool {
        panic!()
    }
}

impl RationalNeg of Neg<Rational> {
    fn neg(a: Rational) -> Rational {
        panic!()
    }
}

impl RationalAdd of Add<Rational> {
    fn add(lhs: Rational, rhs: Rational) -> Rational {
        panic!()
    }
}

impl RationalSub of Sub<Rational> {
    fn sub(lhs: Rational, rhs: Rational) -> Rational {
        panic!()
    }
}

impl RationalMul of Mul<Rational> {
    fn mul(lhs: Rational, rhs: Rational) -> Rational {
        panic!()
    }
}

impl RationalDiv of Div<Rational> {
    fn div(lhs: Rational, rhs: Rational) -> Rational {
        panic!()
    }
}

#[generate_trait]
pub impl RationalAbs of RationalAbsTrait {
    fn abs(self: @Rational) -> Rational {
        panic!()
    }
}

#[generate_trait]
pub impl RationalPow of RationalPowTrait {
    fn pow(self: @Rational, power: i128) -> Rational {
        panic!()
    }

    fn rpow(self: @u128, power: Rational) -> u128 {
        panic!()
    }
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
