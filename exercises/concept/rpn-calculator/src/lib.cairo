#[derive(Drop, Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value: i32,
}

pub fn evaluate(inputs: Span<CalculatorInput>) -> i32 {
    panic!("implement `evaluate`")
}
