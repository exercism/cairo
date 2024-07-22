pub fn find<T, +Drop<T>, +Copy<T>, +PartialOrd<T>>(
    search_array: @Array<T>, value: T
) -> Option<usize> {
    let mut base = 0_usize;
    let mut slice = search_array.span();

    loop {
        let head = slice.slice(0, slice.len() / 2);
        let mut tail = slice.slice(slice.len() / 2, slice.len() - head.len());
        if let Option::Some(middle_element) = tail.pop_front() {
            if *middle_element < value {
                base += head.len() + 1;
                slice = tail.slice(0, tail.len());
            } else if *middle_element > value {
                slice = head;
            } else {
                break Option::Some(base + head.len());
            }
        } else {
            break Option::None;
        }
    }
}
