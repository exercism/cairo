#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
    IndexOutOfBounds: u32
}

pub fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    // validate span
    if span == 0 {
        return Result::Ok(1);
    }
    if span < 0 {
        return Result::Err(Error::NegativeSpan);
    }

    // shadowing
    let span: u32 = span.try_into().unwrap();

    if span > input.len() {
        return Result::Err(Error::SpanTooLong);
    }

    // validate digits
    let mut i = 0;
    let invalid_result: Result<(), Error> = loop {
        if i == input.len() {
            break Result::Ok(());
        };
        if let Result::Err(err) = input.try_into_u64(i) {
            break Result::Err(err);
        };
        i += 1;
    };
    invalid_result?; // propagate the error if present

    // calculate max product
    let (mut current_product, mut from) = product_from(input, 0, span);
    let mut max_product = current_product;

    while from
        + span < input
            .len() {
                current_product /= input.to_u64(from);
                let digit: u64 = input.to_u64(from + span);
                if digit == 0 {
                    let (new_product, new_from) = product_from(input, from + span + 1, span);
                    current_product = new_product;
                    from = new_from;
                } else {
                    current_product *= digit;
                    from += 1;
                }
                if current_product > max_product {
                    max_product = current_product;
                };
            };

    Result::Ok(max_product)
}

fn product_from(input: @ByteArray, from: u32, span: usize) -> (u64, u32) {
    let mut from = from;
    let mut product: u64 = loop {
        if from == input.len() {
            break 0;
        }
        let digit = input.to_u64(from);
        if digit != 0 {
            break digit;
        }
        from += 1;
    };
    let mut digit_count = 1;
    loop {
        if digit_count == span {
            break (product, from);
        }
        if from + digit_count >= input.len() {
            break (0, from);
        }
        let index = from + digit_count;
        let digit: u64 = input.to_u64(index);
        if digit == 0 {
            from = index + 1;
            digit_count = 0;
            product = 1;
        } else {
            product *= digit;
            digit_count += 1;
        }
    }
}

#[generate_trait]
impl ByteArrayToU64 of ByteArrayToU64Trait {
    fn try_into_u64(self: @ByteArray, index: u32) -> Result<u64, Error> {
        if let Option::Some(char) = self.at(index) {
            // ASCII digits are characters 48 through 57
            if 48 <= char && char <= 57 {
                Result::Ok(char.into() - 48)
            } else {
                Result::Err(Error::InvalidDigit(char))
            }
        } else {
            Result::Err(Error::IndexOutOfBounds(index))
        }
    }

    fn to_u64(self: @ByteArray, index: u32) -> u64 {
        self.at(index).unwrap().into() - 48
    }
}

#[cfg(test)]
mod tests;
