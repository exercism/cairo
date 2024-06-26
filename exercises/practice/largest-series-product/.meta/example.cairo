#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
    IndexOutOfBounds: u32
}

pub fn lsp(string_digits: @ByteArray, span: i32) -> Result<u64, Error> {
    if span == 0 {
        return Result::Ok(1);
    }

    if span < 0 {
        return Result::Err(Error::NegativeSpan);
    }
    // shadowing
    let span: u32 = span.try_into().unwrap();

    if span > string_digits.len() {
        return Result::Err(Error::SpanTooLong);
    }

    let mut i = 0;
    let invalid_result: Result<(), Error> = loop {
        if i == string_digits.len() {
            break Result::Ok(());
        };
        if let Result::Err(err) = string_digits.to_u64_wrapped(i) {
            break Result::Err(err);
        };
        i += 1;
    };
    invalid_result?;

    let (mut current_product, mut start_index) = max_product_from(string_digits, span, 0);
    let mut max_product = current_product;

    while start_index
        + span < string_digits
            .len() {
                current_product /= string_digits.to_u64(start_index);
                let digit: u64 = string_digits.to_u64(start_index + span);
                if digit == 0 {
                    let (new_current_product, new_start_index) = max_product_from(
                        string_digits, span, start_index + span + 1
                    );
                    current_product = new_current_product;
                    start_index = new_start_index;
                } else {
                    current_product *= digit;
                    start_index += 1;
                }
                if current_product > max_product {
                    max_product = current_product;
                };
            };

    Result::Ok(max_product)
}

fn max_product_from(string_digits: @ByteArray, span: usize, from: u32) -> (u64, u32) {
    let mut start_index = from;
    let mut current_product: u64 = loop {
        if start_index == string_digits.len() {
            break 0;
        }
        let digit = string_digits.to_u64(start_index);
        if digit != 0 {
            break digit;
        }
        start_index += 1;
    };
    let mut digit_count = 1;
    loop {
        if digit_count == span {
            break (current_product, start_index);
        }
        if start_index + digit_count >= string_digits.len() {
            break (0, start_index);
        }
        let index = start_index + digit_count;
        let digit: u64 = string_digits.to_u64(index);
        if digit == 0 {
            start_index = index + 1;
            digit_count = 0;
            current_product = 1;
        } else {
            current_product *= digit;
            digit_count += 1;
        }
    }
}

#[generate_trait]
impl ByteArrayToU64 of ByteArrayToU64Trait {
    fn to_u64_wrapped(self: @ByteArray, index: u32) -> Result<u64, Error> {
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
