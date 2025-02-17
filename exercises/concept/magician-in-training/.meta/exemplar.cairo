pub fn insert_top(queue: Array<u32>, card: u32) -> Array<u32> {
    let mut queue = queue;
    queue.append(card);
    queue
}

pub fn remove_top_card(queue: Array<u32>) -> Array<u32> {
    let mut span = queue.span();
    let _ = span.pop_back();
    span.into()
}

pub fn insert_bottom(queue: Array<u32>, card: u32) -> Array<u32> {
    let mut new_queue = array![card];
    new_queue.append_span(queue.span());
    new_queue
}

pub fn remove_bottom_card(queue: Array<u32>) -> Array<u32> {
    let mut queue = queue;
    let _ = queue.pop_front();
    queue
}

pub fn check_size_of_stack(queue: Array<u32>, target: u32) -> bool {
    queue.len() == target
}
