use ledger::{format_entries, Currency, Locale, Entry};

#[test]
fn empty_ledger() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn one_entry() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![
        Entry { date: "2015-01-01", description: "Buy present", amount_in_cents: -1000 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Buy present               |      ($10.00)",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn credit_and_debit() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![
        Entry { date: "2015-01-01", description: "Buy present", amount_in_cents: -1000 },
        Entry { date: "2015-01-02", description: "Get present", amount_in_cents: 1000 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Buy present               |      ($10.00)",
        "01/02/2015 | Get present               |       $10.00 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn final_order_tie_breaker_is_change() {
    let currency = Currency::USD;
    let locale = Locale::en_US;

    let entries = array![
        Entry { date: "2015-01-01", description: "Something", amount_in_cents: -1 },
        Entry { date: "2015-01-01", description: "Something", amount_in_cents: 0 },
        Entry { date: "2015-01-01", description: "Something", amount_in_cents: 1 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Something                 |       ($0.01)",
        "01/01/2015 | Something                 |        $0.00 ",
        "01/01/2015 | Something                 |        $0.01 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn overlong_description_is_truncated() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![
        Entry {
            date: "2015-01-01",
            description: "Freude schoner Gotterfunken",
            amount_in_cents: -123456,
        },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Freude schoner Gotterf... |   ($1,234.56)",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn euros() {
    let currency = Currency::EUR;
    let locale = Locale::en_US;
    let entries = array![
        Entry { date: "2015-01-01", description: "Buy present", amount_in_cents: -1000 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Buy present               |      (e10.00)",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn dutch_locale() {
    let currency = Currency::USD;
    let locale = Locale::nl_NL;
    let entries = array![
        Entry { date: "2015-03-12", description: "Buy present", amount_in_cents: 123456 },
    ];

    let expected: Array<ByteArray> = array![
        "Datum      | Omschrijving              | Verandering  ",
        "12-03-2015 | Buy present               |   $ 1.234,56 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn dutch_locale_and_euros() {
    let currency = Currency::EUR;
    let locale = Locale::nl_NL;
    let entries = array![
        Entry { date: "2015-03-12", description: "Buy present", amount_in_cents: 123456 },
    ];
    let expected: Array<ByteArray> = array![
        "Datum      | Omschrijving              | Verandering  ",
        "12-03-2015 | Buy present               |   e 1.234,56 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn dutch_negative_number_with_3_digits_before_decimal_point() {
    let currency = Currency::USD;
    let locale = Locale::nl_NL;
    let entries = array![
        Entry { date: "2015-03-12", description: "Buy present", amount_in_cents: -12345 },
    ];

    let expected: Array<ByteArray> = array![
        "Datum      | Omschrijving              | Verandering  ",
        "12-03-2015 | Buy present               |    $ -123,45 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}

#[test]
#[ignore]
fn american_negative_number_with_3_digits_before_decimal_point() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![
        Entry { date: "2015-03-12", description: "Buy present", amount_in_cents: -12345 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "03/12/2015 | Buy present               |     ($123.45)",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}


#[test]
#[ignore]
fn multiple_entries_on_same_date_ordered_by_description() {
    let currency = Currency::USD;
    let locale = Locale::en_US;
    let entries = array![
        Entry { date: "2015-01-01", description: "Buy present", amount_in_cents: -1000 },
        Entry { date: "2015-01-01", description: "Get present", amount_in_cents: 1000 },
    ];

    let expected: Array<ByteArray> = array![
        "Date       | Description               | Change       ",
        "01/01/2015 | Buy present               |      ($10.00)",
        "01/01/2015 | Get present               |       $10.00 ",
    ];
    let result = format_entries(currency, locale, entries);

    assert_eq!(result, expected);
}
