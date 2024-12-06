#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: ByteArray) -> Result<ByteArray, ByteArray> {
        panic!("implement `calculate`")
    }
}
