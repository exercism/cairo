// Changes in the Refactored Code

// 1) format_entries function now uses format_row to create each ledger entry, reducing redundancy.

// 2) format_row function to format each row, combining date, description, and amount formatting into a
// single string.

// 3) format_date Refactor split date formatting into a standalone function that uses split_date for
// modular handling.

// 4) split_date Function introduced to extract year, month, and day components, improving clarity
// and code reuse.

// 5) format_amount Improvements refactored logic for formatting amounts to make negative handling,
// spacing, and locale-specific formatting cleaner.

// 6) format_number refinement Handles separators and decimal points for numbers more
// systematically.

// 7) Enhanced add_sep Split logic into separate steps for readability, making prefix, middle, and
// final result assembly explicit.

// 8)format_description logic for truncation and padding, aligning with coding standards.

// 9) Added AMOUNT_COLUMN_WIDTH, MAX_DESCRIPTION_LENGTH and FORMATTED_DESCRIPTION_LENGTH constants
// for readability and maintainability.

// 10) Imported AppendFormattedToByteArray to handle the conversion of byteArray to integer.


//     Overall, the refactored code is modular, better adheres to single-responsibility principles, and
//     improves readability while ensuring maintainability.
 
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

#[derive(Debug, PartialEq, Drop)]
pub struct Entry {
    pub date: ByteArray,
    pub description: ByteArray,
    pub amount_in_cents: i32,
}


pub fn format_entries(
    currency: Currency, locale: Locale, entries: Array<Entry>,
) -> Array<ByteArray> {
    let mut ledger: Array<ByteArray> = array![];

    // Step 1: Define the header based on the locale
    let header = match @locale {
        Locale::en_US => "Date       | Description               | Change       ",
        Locale::nl_NL => "Datum      | Omschrijving              | Verandering  ",
    };
    ledger.append(header);
    // Step 2: Process transactions
    for entry in entries {
        let row = format_row(@currency, @locale, entry);
        ledger.append(row);
    };

    ledger
}

fn format_row(currency: @Currency, locale: @Locale, entry: Entry) -> ByteArray {
    let date = format_date(@entry.date, locale);
    let amount_in_cents = format_amount(@entry.amount_in_cents, currency, locale);
    format!("{} | {} | {}", date, format_description(entry.description), amount_in_cents)
}

// format date based on the locale
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

fn format_amount(amount_in_cents: @i32, currency: @Currency, locale: @Locale) -> ByteArray {
    let amount_in_cents = format!("{amount_in_cents}");
    let mut int_value: u32 = 0;
    let mut negative = false;
    let mut i = 0;

    if amount_in_cents[i] == '-' {
        negative = true;
        i += 1;
    }

    const AMOUNT_COLUMN_WIDTH: usize = 13;
    while i < amount_in_cents.len() {
        let zero_ascii = '0';
        if let Option::Some(digit) = Option::Some(amount_in_cents[i] - zero_ascii) {
            int_value = int_value * 10 + digit.into();
        }
        i += 1;
    };

    let formatted_value = format_number(int_value, negative, currency, locale);
    let mut extra = "";

    if formatted_value.len() < AMOUNT_COLUMN_WIDTH {
        let diff = AMOUNT_COLUMN_WIDTH - formatted_value.len();
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

        if negative {
            result.append_byte('-');
        }
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
        fraction.append_formatted_to_byte_array(ref result, 10);
    } else {
        fraction.append_formatted_to_byte_array(ref result, 10);
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

    // Step 1: Append the first character if length > 3
    let mut prefix = "";
    if temp.len() > 3 {
        prefix.append_byte(temp[0]);
    } else {
        result += temp; // If length <= 3, the result is directly temp
        return result;
    }

    // Step 2: Build the middle part with separators
    let mut middle = "";
    let mut i = 1;
    let mut sep = 0;
    while i < temp.len() {
        if sep == 0 {
            if locale == @Locale::nl_NL {
                middle.append_byte('.');
            } else {
                middle.append_byte(',');
            }
            sep = 3;
        }
        middle.append_byte(temp[i]);
        i += 1;
        sep -= 1;
    };

    // Step 3: Combine prefix and middle
    result = ByteArrayTrait::concat(@prefix, @middle);

    result
}

fn format_description(transaction: ByteArray) -> ByteArray {
    let mut formatted = "";
    const MAX_DESCRIPTION_LENGTH: usize = 22;
    const FORMATTED_DESCRIPTION_LENGTH: usize = 25;

    if transaction.len() > MAX_DESCRIPTION_LENGTH {
        let mut i = 0;
        while i < MAX_DESCRIPTION_LENGTH {
            formatted.append_byte(transaction[i]);
            i += 1;
        };
        formatted += "...";
    } else {
        formatted += transaction;
        while formatted.len() < FORMATTED_DESCRIPTION_LENGTH {
            formatted.append_byte(' ');
        };
    }

    formatted
}
