pub fn slices(series: ByteArray, slice_length: usize) -> Array<ByteArray> {
    assert!(series.len() != 0, "series cannot be empty");
    assert!(slice_length != 0, "slice length cannot be zero");
    assert!(slice_length <= series.len(), "slice length cannot be greater than series length");

    let max_start = series.len() - slice_length + 1;

    let mut all_slices = array![];
    for i in 0
        ..max_start {
            let mut slice = "";
            for j in i..(i + slice_length) {
                slice.append_byte(series[j]);
            };
            all_slices.append(slice);
        };

    all_slices
}
