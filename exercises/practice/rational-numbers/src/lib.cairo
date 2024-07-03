use core::fmt::{Debug, Formatter, Error};

#[derive(Drop, Debug)]
struct Rational {}

#[generate_trait]
impl RationalImpl of RationalTrait {
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
impl RationalAbs of RationalAbsTrait {
    fn abs(self: @Rational) -> Rational {
        panic!()
    }
}

#[generate_trait]
impl RationalPow of RationalPowTrait {
    fn pow(self: @Rational, power: i128) -> Rational {
        panic!()
    }

    fn rpow(self: @u128, power: Rational) -> u128 {
        panic!()
    }
}

fn abs(n: i128) -> u128 {
    let val = if n < 0 {
        n * -1
    } else {
        n
    };
    val.try_into().unwrap()
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
