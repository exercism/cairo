// Refactored code
use core::to_byte_array::AppendFormattedToByteArray;

#[derive(Debug, PartialEq, Drop)]
pub enum Currency {
    USD,
    EUR,
}

#[derive(Debug, PartialEq, Drop)]
pub enum Locale {
    en_US,
    nl_NL,
}

pub fn format_entries(
    currency: Currency, locale: Locale, transactions: Array<(ByteArray, ByteArray, ByteArray)>
) -> Array<ByteArray> {
    let mut ledger: Array<ByteArray> = array![];

    // Step 1: Define the header based on the locale
    let header = match @locale {
        Locale::en_US => "Date       | Description               | Change       ",
        Locale::nl_NL => "Datum      | Omschrijving              | Verandering  ",
    };
    ledger.append(header);

    // Step 2: Process transactions
    for (
        date, transaction, change
    ) in transactions {
        let formatted_date = format_date(@date, @locale);

        // Format the change based on the currency and locale
        let formatted_change = format_change(@change, @currency, @locale);

        // Format the transaction row
        let mut row = formatted_date;
        row += " | ";
        row += format_transaction(transaction);
        row += " | ";
        row += formatted_change;

        // Append the row to the ledger
        ledger.append(row);
    };

    ledger
}

// format date based on the locale handled in 1 function
fn format_date(date: @ByteArray, locale: @Locale) -> ByteArray {
    let (mut year, mut month, mut day) = split_date(date);
    match locale {
        Locale::en_US => {
            day += "/";
            month += "/";
            ByteArrayTrait::concat(@month, @ByteArrayTrait::concat(@day, @year))
        },
        Locale::nl_NL => {
            day += "-";
            month += "-";
            ByteArrayTrait::concat(@day, @ByteArrayTrait::concat(@month, @year))
        },
    }
}

// split date into year, month and day
fn split_date(date: @ByteArray) -> (ByteArray, ByteArray, ByteArray) {
    let mut year = "";
    let mut month = "";
    let mut day = "";
    let mut sep = 0;
    let mut i = 0;

    while i < date.len() {
        if sep == 0 && i < 4 && date[i] != '-' {
            year.append_byte(date[i]);
        } else if date[i] == '-' {
            sep += 1;
        } else if sep == 1 && i < 7 && date[i] != '-' {
            month.append_byte(date[i]);
        } else {
            day.append_byte(date[i]);
        }
        i += 1;
    };

    (year, month, day)
}

fn format_change(change: @ByteArray, currency: @Currency, locale: @Locale) -> ByteArray {
    let mut int_value: u32 = 0;
    let mut negative = false;
    let mut i = 0;

    if change[i] == '-' {
        negative = true;
        i += 1;
    }

    while i < change.len() {
        if let Option::Some(digit) = char_to_digit(change[i]) {
            int_value = int_value * 10 + digit.into();
        }
        i += 1;
    };

    let formatted_value = format_number(int_value, negative, currency, locale);
    let mut extra = "";

    if formatted_value.len() < 13 {
        let diff = 13 - formatted_value.len();
        let mut i = 0;
        while i < diff {
            extra += " ";
            i += 1;
        }
    }
    ByteArrayTrait::concat(@extra, @formatted_value)
}

fn format_number(value: u32, negative: bool, currency: @Currency, locale: @Locale) -> ByteArray {
    let mut result = "";

    if negative && locale == @Locale::en_US {
        result.append_byte('(');
    }

    match currency {
        Currency::USD => result.append_byte('$'),
        Currency::EUR => result.append_byte('e'),
    };

    if locale == @Locale::nl_NL {
        result.append_byte(' ');
    }

    if negative && locale != @Locale::en_US {
        result.append_byte('-');
    }

    let whole = value / 100;

    result += add_sep(whole, locale);
    let fraction = value % 100;
    if locale == @Locale::en_US {
        result.append_byte('.');
    } else {
        result.append_byte(',');
    }

    if fraction < 10 {
        result.append_byte('0');
        @fraction.append_formatted_to_byte_array(ref result, 10);
    } else {
        @fraction.append_formatted_to_byte_array(ref result, 10);
    }

    if negative && locale == @Locale::en_US {
        result.append_byte(')');
    } else {
        result.append_byte(' ');
    }

    result
}


fn add_sep(whole: u32, locale: @Locale) -> ByteArray {
    let mut result = "";
    let mut temp = "";
    @whole.append_formatted_to_byte_array(ref temp, 10);
    if temp.len() > 3 {
        result.append_byte(temp[0]);
        let mut i = 1;
        let mut sep = 0;
        while i < temp.len() {
            if sep == 0 {
                if locale == @Locale::nl_NL {
                    result.append_byte('.');
                } else {
                    result.append_byte(',');
                }
                sep = 3;
            }
            result.append_byte(temp[i]);
            i += 1;
            sep -= 1;
        }
    } else {
        result += temp;
    }
    result
}

fn format_transaction(transaction: ByteArray) -> ByteArray {
    let mut formatted = "";

    if transaction.len() > 22 {
        let mut i = 0;
        while i < 22 {
            formatted.append_byte(transaction[i]);
            i += 1;
        };
        formatted += "...";
    } else {
        formatted += transaction;
        while formatted.len() < 25 {
            formatted.append_byte(' ');
        };
    }

    formatted
}


fn char_to_digit(c: u8) -> Option<u8> {
    if c >= '0' && c <= '9' {
        Option::Some(c - '0')
    } else {
        Option::None
    }
}
