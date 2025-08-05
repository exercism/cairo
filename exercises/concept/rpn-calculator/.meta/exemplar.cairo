#[derive(Drop, Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value: i32,
}

pub fn evaluate(inputs: Span<CalculatorInput>) -> Option<i32> {
    let mut stack: Array<i32> = ArrayTrait::new();

    let mut cancelled = false;

    for input in inputs {
        match input {
            CalculatorInput::Add => {
                let mut stack_span = stack.span();
                let rhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                let lhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                stack = array![];
                stack.append_span(stack_span);
                stack.append(lhs + rhs);
            },
            CalculatorInput::Subtract => {
                let mut stack_span = stack.span();
                let rhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                let lhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };

                stack = array![];
                stack.append_span(stack_span);
                stack.append(lhs - rhs);
            },
            CalculatorInput::Multiply => {
                let mut stack_span = stack.span();
                let rhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                let lhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };

                stack = array![];
                stack.append_span(stack_span);
                stack.append(lhs * rhs);
            },
            CalculatorInput::Divide => {
                let mut stack_span = stack.span();
                let rhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                let lhs = match stack_span.pop_back() {
                    Option::Some(value) => *value,
                    Option::None => {
                        cancelled = true;
                        break;
                    },
                };
                stack = array![];
                stack.append_span(stack_span);
                stack.append(lhs / rhs);
            },
            CalculatorInput::Value(value) => stack.append(*value),
        }
    };

    if cancelled {
        return Option::None;
    }

    let output = stack.pop_front();
    if stack.is_empty() {
        output
    } else {
        Option::None
    }
}
