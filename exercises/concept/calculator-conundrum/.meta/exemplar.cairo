#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: Option<ByteArray>) -> Result<ByteArray, ByteArray> {
        let operation = operation.expect('Operation cannot be null');
        if operation == "+" {
            Result::Ok(format!("{} + {} = {}", a, b, a + b))
        } else if operation == "*" {
            Result::Ok(format!("{} * {} = {}", a, b, a * b))
        } else if operation == "/" {
            assert!(b != 0, "Division by zero is not allowed");
            Result::Ok(format!("{} / {} = {}", a, b, a / b))
        } else if operation == "" {
            Result::Err("Operation cannot be an empty string")
        } else {
            Result::Err("Operation is out of range")
        }
    }
}
