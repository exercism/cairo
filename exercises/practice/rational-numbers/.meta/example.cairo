use alexandria_math::gcd_of_n_numbers::gcd_two_numbers;
use alexandria_math::fast_power::fast_power;

#[derive(Drop)]
struct Rational {
    numer: i128,
    denom: i128,
}

#[generate_trait]
impl RationalImpl of RationalTrait {
    fn new(numer: i128, denom: i128) -> Rational {
        let numer_abs = abs(numer);
        let denom_abs = abs(denom);
        let gcd_num = gcd_two_numbers(numer_abs, denom_abs);

        let mut numer_minif = to_i128(numer_abs / gcd_num);
        let denom_minif = to_i128(denom_abs / gcd_num);

        if denom < 0 {
            numer_minif *= -1;
        }

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
        let numer = to_u128(*self.numer);
        let denom = to_u128(*self.denom);
        if power < 0 {
            RationalTrait::new(
                to_i128(fast_power(denom, abs(power))), to_i128(fast_power(numer, abs(power)))
            )
        } else {
            RationalTrait::new(
                to_i128(fast_power(numer, to_u128(power))),
                to_i128(fast_power(denom, to_u128(power)))
            )
        }
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
