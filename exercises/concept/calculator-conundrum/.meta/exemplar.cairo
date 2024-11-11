#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: Option<ByteArray>) -> Result<ByteArray, ByteArray> {
        let operation = operation.expect('Operation cannot be null');
        if operation == "+" {
            Result::Ok(format!("{} + {} = {}", a, b, a + b))
        } else if operation == "*" {
            Result::Ok(format!("{} * {} = {}", a, b, a * b))
        } else if operation == "/" {
            if b == 0 {
                Result::Err("Division by zero is not allowed")
            } else {
                Result::Ok(format!("{} / {} = {}", a, b, a / b))
            }
        } else if operation == "" {
            Result::Err("Operation cannot be an empty string")
        } else {
            Result::Err("Operation is out of range")
        }
    }
}
