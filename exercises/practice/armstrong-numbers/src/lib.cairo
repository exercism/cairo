use alexandria_math::armstrong_number;

fn is_armstrong_number(num: u128) -> bool {
    armstrong_number::is_armstrong_number(num.into())
}

#[cfg(test)]
mod tests;
