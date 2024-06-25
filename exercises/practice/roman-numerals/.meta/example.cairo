#[derive(Drop, Debug, PartialEq)]
pub struct Roman {
    value: ByteArray,
}

#[generate_trait]
impl RomanImpl of RomanTrait {
    fn from_u32(num: u32) -> Roman {
        let mut ROMAN_MAP: Array<(u32, ByteArray)> = array![
            (1000, "M"),
            (900, "CM"),
            (500, "D"),
            (400, "CD"),
            (100, "C"),
            (90, "XC"),
            (50, "L"),
            (40, "XL"),
            (10, "X"),
            (9, "IX"),
            (5, "V"),
            (4, "IV"),
            (1, "I"),
        ];

        let mut value: ByteArray = "";
        let mut current_num = num;
        while let Option::Some((numeric, roman_string)) = ROMAN_MAP
            .pop_front() {
                while current_num >= numeric {
                    value.append(@roman_string);
                    current_num -= numeric;
                }
            };

        Roman { value }
    }
}

impl U32IntoRoman of Into<u32, Roman> {
    #[must_use]
    fn into(self: u32) -> Roman {
        RomanImpl::from_u32(self)
    }
}

impl RomanIIntoByteArray of Into<Roman, ByteArray> {
    #[must_use]
    fn into(self: Roman) -> ByteArray {
        self.value
    }
}

#[cfg(test)]
mod tests;
