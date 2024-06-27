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
    from: u32,
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
    let product = product_from(input, span, 0, span, Product { value: 1, from: 0 })?;

    next_max_product(input, span, product.value, product)
}

fn product_from(
    input: @ByteArray, span: u32, from: u32, remaining: u32, product: Product
) -> Result<Product, Error> {
    if remaining == 0 {
        return Result::Ok(product);
    }
    if from + remaining > input.len() {
        return Result::Ok(Product { value: 0, from });
    }

    let digit = input.at(from).try_into_digit()?;
    if digit != 0 {
        return product_from(
            input,
            span,
            from + 1,
            remaining - 1,
            Product { value: product.value * digit, from: product.from }
        );
    } else {
        return product_from(input, span, from + 1, span, Product { value: 1, from: from + 1 });
    }
}

fn next_max_product(
    input: @ByteArray, span: u32, max: u64, current_product: Product
) -> Result<u64, Error> {
    if current_product.from + span >= input.len() {
        return Result::Ok(max);
    }

    // safe to unwrap, we already processed this digit before 
    let reduced_value = current_product.value
        / input.at(current_product.from).try_into_digit().unwrap();

    let next_digit = input.at(current_product.from + span).try_into_digit()?;

    let product = if next_digit == 0 {
        product_from(
            input,
            span,
            current_product.from + span + 1,
            span,
            Product { value: 1, from: current_product.from + span + 1 }
        )?
    } else {
        Product { value: reduced_value * next_digit, from: current_product.from + 1 }
    };

    if product.value > max {
        next_max_product(input, span, product.value, product)
    } else {
        next_max_product(input, span, max, product)
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
