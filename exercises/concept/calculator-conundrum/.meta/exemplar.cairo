#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: Option<felt252>) -> Result<ByteArray, ByteArray> {
        match operation {
            Option::Some(operation) => {
                if operation == '+' {
                    Result::Ok(format!("{} + {} = {}", a, b, a + b))
                } else if operation == '*' {
                    Result::Ok(format!("{} * {} = {}", a, b, a * b))
                } else if operation == '/' {
                    if b == 0 {
                        Result::Err("Division by zero is not allowed")
                    } else {
                        Result::Ok(format!("{} / {} = {}", a, b, a / b))
                    }
                } else if operation == '' {
                    Result::Err("Operation cannot be an empty string")
                } else {
                    Result::Err("Operation is out of range")
                }
            },
            Option::None => Result::Err("Operation cannot be null"),
        }
    }
}
