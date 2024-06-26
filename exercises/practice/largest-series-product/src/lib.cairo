#[derive(Drop, Copy, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
    IndexOutOfBounds
}

pub fn lsp(input: @ByteArray, span: i32) -> Result<u64, Error> {
    // validate span
    if span == 0 {
        return Result::Ok(1);
    }
    if span < 0 {
        return Result::Err(Error::NegativeSpan);
    }

    // shadowing to make span of unsigned type
    let span: u32 = span.try_into().unwrap();

    if span > input.len() {
        return Result::Err(Error::SpanTooLong);
    }

    // calculate first max product
    let mut current_product = product_from(input, 0, span);
    // use '?' to propagate the error if it occurred
    let mut max_product = current_product?.value;

    while let Result::Ok(Product { value, from }) =
        current_product {
            if from + span >= input.len() {
                break;
            }

            // safe to unwrap, we already processed this digit before 
            let reduced_value = value / input.at(from).try_into_digit().unwrap();

            match input.at(from + span).try_into_digit() {
                Result::Ok(next_digit) => {
                    if next_digit == 0 {
                        current_product = product_from(input, from + span + 1, span);
                    } else {
                        current_product =
                            Result::Ok(
                                Product { value: reduced_value * next_digit, from: from + 1 }
                            );
                    }
                    match current_product {
                        Result::Ok(prod) => {
                            if prod.value > max_product {
                                max_product = prod.value;
                            };
                        },
                        Result::Err(_) => { break; }
                    }
                },
                Result::Err(err) => {
                    current_product = Result::Err(err);
                    break;
                }
            };
        };

    // propagate the error if it occurred
    current_product?;

    Result::Ok(max_product)
}

#[derive(Drop, Copy)]
struct Product {
    value: u64,
    from: u32,
}

fn product_from(input: @ByteArray, from: u32, span: usize) -> Result<Product, Error> {
    // shadow with a mutable variable
    let mut from = from;
    // assign the first non-zero digit to the product
    let mut product_result: Result<Product, Error> = loop {
        if from == input.len() {
            // no non-zero digit was found
            break Result::Ok(Product { value: 0, from });
        }
        match input.at(from).try_into_digit() {
            Result::Ok(digit) => {
                if digit != 0 {
                    break Result::Ok(Product { value: digit, from });
                }
                from += 1;
            },
            Result::Err(err) => { break Result::Err(err); }
        };
    };

    let Product { mut value, mut from } = product_result?;
    let mut digits_in_product = 1;

    loop {
        // found a non-zero product
        if digits_in_product == span {
            break Result::Ok(Product { value, from });
        }
        // we couldn't find a non-zero product
        if from + digits_in_product >= input.len() {
            break Result::Ok(Product { value: 0, from });
        }
        match input.at(from + digits_in_product).try_into_digit() {
            Result::Ok(digit) => {
                if digit == 0 {
                    // jump over the digit 0, recalculate the product
                    from += digits_in_product + 1;
                    digits_in_product = 0;
                    value = 1;
                } else {
                    value *= digit;
                    digits_in_product += 1;
                }
            },
            Result::Err(err) => { break Result::Err(err); }
        }
    }
}

/// Helper functions
#[generate_trait]
impl ByteArrayCharToU64 of ByteArrayCharToU64Trait {
    fn try_into_digit(self: @Option<u8>) -> Result<u64, Error> {
        if let Option::Some(char) = (*self) {
            // ASCII digits are characters 48 through 57
            if 48 <= char && char <= 57 {
                Result::Ok(char.into() - 48)
            } else {
                Result::Err(Error::InvalidDigit(char))
            }
        } else {
            Result::Err(Error::IndexOutOfBounds)
        }
    }
}

#[cfg(test)]
mod tests;
