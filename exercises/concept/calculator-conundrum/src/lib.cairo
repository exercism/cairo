#[generate_trait]
pub impl SimpleCalculatorImpl of SimpleCalculatorTrait {
    fn calculate(a: i32, b: i32, operation: Option<felt252>) -> Result<ByteArray, ByteArray> {
        panic!("implement `calculate`")
    }
}
