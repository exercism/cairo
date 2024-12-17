use core::fmt::Formatter;
use core::dict::Felt252Dict;

#[test]
fn transform_one_value() {
    let legacy_data = input_from(array![(1, array!['A'])]);

    let expected = expected_from(array![('a', 1)]);

    assert_dicts_eq(expected, etl::transform(legacy_data));
}

#[test]
#[ignore]
fn transform_more_values() {
    #[cairofmt::skip]
    let legacy_data = input_from(array![
        (1, array!['A', 'E', 'I', 'O', 'U']),
    ]);
    #[cairofmt::skip]
    let expected = expected_from(array![
        ('a', 1),
        ('e', 1),
        ('i', 1),
        ('o', 1),
        ('u', 1),
    ]);

    assert_dicts_eq(expected, etl::transform(legacy_data));
}

#[test]
#[ignore]
fn more_keys() {
    #[cairofmt::skip]
    let legacy_data = input_from(array![
        (1, array!['A', 'E']),
        (2, array!['D', 'G']),
    ]);
    #[cairofmt::skip]
    let expected = expected_from(array![
        ('a', 1),
        ('e', 1),
        ('d', 2),
        ('g', 2),
    ]);

    assert_dicts_eq(expected, etl::transform(legacy_data));
}

#[test]
#[ignore]
fn full_dataset() {
    let legacy_data = input_from(
        array![
            (1, array!['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']),
            (2, array!['D', 'G']),
            (3, array!['B', 'C', 'M', 'P']),
            (4, array!['F', 'H', 'V', 'W', 'Y']),
            (5, array!['K']),
            (8, array!['J', 'X']),
            (10, array!['Q', 'Z']),
        ],
    );

    let expected = expected_from(
        array![
            ('a', 1),
            ('b', 3),
            ('c', 3),
            ('d', 2),
            ('e', 1),
            ('f', 4),
            ('g', 2),
            ('h', 4),
            ('i', 1),
            ('j', 8),
            ('k', 5),
            ('l', 1),
            ('m', 3),
            ('n', 1),
            ('o', 1),
            ('p', 3),
            ('q', 10),
            ('r', 1),
            ('s', 1),
            ('t', 1),
            ('u', 1),
            ('v', 4),
            ('w', 4),
            ('x', 8),
            ('y', 4),
            ('z', 10),
        ],
    );

    assert_dicts_eq(expected, etl::transform(legacy_data));
}

fn input_from(v: Array<(u32, Array<u8>)>) -> Felt252Dict<Nullable<Span<u8>>> {
    let mut dict: Felt252Dict<Nullable<Span<u8>>> = Default::default();
    for (num, chars) in v {
        dict.insert(num.into(), NullableTrait::new(chars.span()));
    };
    dict
}

fn expected_from(v: Array<(u8, u32)>) -> Felt252Dict<u32> {
    let mut dict: Felt252Dict<u32> = Default::default();
    for (char, num) in v {
        dict.insert(char.into(), num);
    };
    dict
}


fn assert_dicts_eq(expected: Felt252Dict<u32>, actual: Felt252Dict<u32>) {
    let mut expected = expected;
    let mut actual = actual;
    let mut unequal = false;
    for char in 'a'..('z' + 1_u8) {
        if expected.get(char.into()) != actual.get(char.into()) {
            unequal = true;
            break;
        }
    };
    if unequal {
        let mut f: Formatter = Default::default();
        writeln!(f, "expected:").expect('write expected');
        f = write_dict(f, expected);
        writeln!(f, "actual:").expect('write expected');
        f = write_dict(f, actual);
        panic!("{}", f.buffer);
    }
}

fn write_dict(mut f: Formatter, dict: Felt252Dict<u32>) -> Formatter {
    let mut dict = dict;
    writeln!(f, "{{").expect('should write {');
    for char in 'a'..('z' + 1_u8) {
        writeln!(f, "    \"{}\": {},", char, dict.get(char.into())).expect('should write char');
    };
    writeln!(f, "}}").expect('should write }');
    f
}
