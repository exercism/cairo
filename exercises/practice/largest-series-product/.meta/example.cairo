#[derive(Drop, Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit: u8,
    NegativeSpan,
    IndexOutOfBounds
}

#[derive(Drop, Copy)]
struct Product {
    value: u64,
    start_index: u32,
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
    // use '?' to propagate the error if it occurred
    let product = product_from(input, span, 0, span, Product { value: 1, start_index: 0 })?;

    max_product(input, span, product.value, product.start_index, product.value)
}

fn product_from(
    input: @ByteArray, span: u32, from: u32, remaining: u32, accumulated: Product
) -> Result<Product, Error> {
    if remaining == 0 {
        return Result::Ok(accumulated);
    }
    if from + remaining > input.len() {
        // we couldn't find a span of non-zero digits,
        // so all products must be zero
        return Result::Ok(Product { value: 0, start_index: from });
    }

    let digit = input.at(from).try_into_digit()?;

    if digit == 0 {
        return product_from(
            input, span, from + 1, span, Product { value: 1, start_index: from + 1 }
        );
    } else {
        return product_from(
            input,
            span,
            from + 1,
            remaining - 1,
            Product { value: accumulated.value * digit, start_index: accumulated.start_index }
        );
    }
}

fn max_product(
    input: @ByteArray, span: u32, previous: u64, from: u32, max: u64
) -> Result<u64, Error> {
    if from + span >= input.len() {
        return Result::Ok(max);
    }

    let next_digit = input.at(from + span).try_into_digit()?;

    let next = if next_digit == 0 {
        // every product that includes digit 0 will be 0,
        // so calculate the next product after the digit 0
        product_from(
            input, span, from + span + 1, span, Product { value: 1, start_index: from + span + 1 }
        )?
    } else {
        // safe to unwrap, we already processed this digit before 
        let common_product = previous / input.at(from).try_into_digit().unwrap();
        Product { value: common_product * next_digit, start_index: from + 1 }
    };

    if next.value > max {
        max_product(input, span, next.value, next.start_index, next.value)
    } else {
        max_product(input, span, next.value, next.start_index, max)
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
