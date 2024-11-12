#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: ByteArray) -> Result<ByteArray, ByteArray> {
        assert!(operation != "", "Operation cannot be an empty string");

        if operation == "+" {
            Result::Ok(format!("{} + {} = {}", a, b, a + b))
        } else if operation == "*" {
            Result::Ok(format!("{} * {} = {}", a, b, a * b))
        } else if operation == "/" {
            assert(b != 0, 'Division by zero is not allowed');
            Result::Ok(format!("{} / {} = {}", a, b, a / b))
        } else {
            Result::Err("Operation is out of range")
        }
    }
}
