pub fn recite(items: @Array<ByteArray>) -> ByteArray {
    let mut stanzas: ByteArray = "";
    for index in 0
        ..items
            .len() {
                if index == items.len() - 1 {
                    stanzas += format!("And all for the want of a {}.", items[0]);
                } else {
                    stanzas +=
                        format!(
                            "For want of a {} the {} was lost.\n", items[index], items[index + 1]
                        );
                }
            };
    stanzas
}
