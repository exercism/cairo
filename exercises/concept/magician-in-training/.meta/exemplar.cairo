pub fn insert_top(stack: Array<u32>, card: u32) -> Array<u32> {
    let mut stack = stack;
    stack.append(card);
    stack
}

pub fn remove_top_card(stack: Array<u32>) -> Array<u32> {
    let mut span = stack.span();
    let _ = span.pop_back();
    span.into()
}

pub fn insert_bottom(stack: Array<u32>, card: u32) -> Array<u32> {
    let mut new_stack = array![card];
    new_stack.append_span(stack.span());
    new_stack
}

pub fn remove_bottom_card(stack: Array<u32>) -> Array<u32> {
    let mut stack = stack;
    let _ = stack.pop_front();
    stack
}

pub fn check_size_of_stack(stack: Array<u32>, target: u32) -> bool {
    stack.len() == target
}
