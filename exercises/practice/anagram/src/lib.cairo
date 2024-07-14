use alexandria_sorting::MergeSort;

#[derive(Drop, Debug)]
struct Set {
    values: Array<ByteArray>
}

#[generate_trait]
impl SetImpl of SetTrait {
    fn new(values: Array<ByteArray>) -> Set {
        Set { values }
    }
}

impl SetEq of PartialEq<Set> {
    fn eq(lhs: @Set, rhs: @Set) -> bool {
        let len = lhs.values.len();
        if len != rhs.values.len() {
            return false;
        }
        let mut i = 0;
        loop {
            if i == len {
                break true;
            }
            let l_item = lhs.values.at(i);
            let mut j = 0;
            while j != len {
                if IgnoreCase::eq(l_item, rhs.values.at(j)) {
                    break;
                }
                j += 1;
            };
            if j == len {
                break false;
            }
            i += 1;
        }
    }

    fn ne(lhs: @Set, rhs: @Set) -> bool {
        !(lhs == rhs)
    }
}

fn anagrams_for(word: @ByteArray, inputs: @Set) -> Set {
    let mut word_sorted = @sort(word);
    let mut anagrams = Set { values: array![] };
    let mut i = inputs.values.len();

    while i != 0 {
        i -= 1;
        let candidate = inputs.values[i];

        let is_anagram = word.len() == candidate.len()
            && IgnoreCase::ne(word, candidate)
            && IgnoreCaseArray::eq(word_sorted, @sort(candidate));

        if is_anagram {
            anagrams.values.append(format!("{candidate}"));
        }
    };

    anagrams
}

impl IgnoreCase of PartialEq<ByteArray> {
    fn eq(lhs: @ByteArray, rhs: @ByteArray) -> bool {
        let len = lhs.len();
        if len != rhs.len() {
            return false;
        }
        let mut i = 0;
        loop {
            if i == len {
                break true;
            }
            if lowercase(@lhs[i]) != lowercase(@rhs[i]) {
                break false;
            }
            i += 1;
        }
    }

    fn ne(lhs: @ByteArray, rhs: @ByteArray) -> bool {
        !IgnoreCase::eq(lhs, rhs)
    }
}

fn sort(word: @ByteArray) -> Array<u8> {
    MergeSort::sort(to_char_array(word).span())
}

fn to_char_array(word: @ByteArray) -> Array<u8> {
    let mut chars: Array<u8> = array![];
    let mut i = word.len();
    while i != 0 {
        i -= 1;
        chars.append(lowercase(@word[i]));
    };
    chars
}

impl IgnoreCaseArray of PartialEq<Array<u8>> {
    fn eq(lhs: @Array<u8>, rhs: @Array<u8>) -> bool {
        if lhs.len() != rhs.len() {
            return false;
        }
        let mut i = lhs.len();
        loop {
            if i == 0 {
                break true;
            }
            i -= 1;
            if lowercase(lhs.at(i)) != lowercase(rhs.at(i)) {
                break false;
            }
        }
    }

    fn ne(lhs: @Array<u8>, rhs: @Array<u8>) -> bool {
        !IgnoreCaseArray::eq(lhs, rhs)
    }
}

fn lowercase(char: @u8) -> u8 {
    if *char < 97 {
        *char + 32
    } else {
        *char
    }
}

#[cfg(test)]
mod tests;
