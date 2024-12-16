use core::to_byte_array::{AppendFormattedToByteArray};

#[derive(Debug, PartialEq, Drop)]
pub enum Currency {
    USD,
    EUR,
    JPY,
}

#[derive(Debug, PartialEq, Drop)]
pub enum Locale {
    en_US,
    nl_NL,
}

pub fn format_entries(
    currency: Currency, locale: Locale, transactions: Array<(ByteArray, ByteArray, ByteArray)>
) -> Array<ByteArray> {
    let mut ledger: Array<ByteArray> = ArrayTrait::new();
    let mut header = "";
    if locale == Locale::en_US {
        header = "Date       | Description               | Change       ";
    } else if locale == Locale::nl_NL {
        header = "Datum      | Omschrijving              | Verandering  ";
    }

    ledger.append(header);
    for (
        date, transaction, change
    ) in transactions {
        let mut formatted_date = "";
        if locale == Locale::en_US {
            let mut year = "/";
            let mut month = "";
            let mut day = "/";

            let mut i = 0;
            let mut sep = 0;

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

            formatted_date = ByteArrayTrait::concat(@month, @ByteArrayTrait::concat(@day, @year))
        } else {
            let mut year = "-";
            let mut month = "-";
            let mut day = "";

            let mut i = 0;
            let mut sep = 0;

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

            formatted_date = ByteArrayTrait::concat(@day, @ByteArrayTrait::concat(@month, @year));
        }

        let mut formatted_change = "";
        if currency == Currency::USD {
            if locale == Locale::en_US {
                let mut result = "$";
                let mut i = 0;
                let mut op = "";
                let mut cl = "";
                if change[i] == '-' {
                    op += "(";
                    cl += ")";
                    i += 1;
                } else {
                    op += " ";
                    cl += " ";
                }
                let mut int: u32 = 0;
                while i < change.len() {
                    let c = char_to_digit(change[i]);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; }
                    }
                    i += 1;
                };

                let val = int / 100;
                let mut temp = "";
                @val.append_formatted_to_byte_array(ref temp, 10);
                if temp.len() > 3 {
                    result.append_byte(temp[0]);
                    let mut i = 1;
                    let mut sep = 0;
                    while i < temp.len() {
                        if sep == 0 {
                            result.append_byte(',');
                            sep = 3;
                        }
                        result.append_byte(temp[i]);
                        i += 1;
                        sep -= 1;
                    }
                } else {
                    result += temp;
                }

                result += ".";
                let mut rem = int % 100;
                if int < 10 {
                    result += "0";
                }

                @rem.append_formatted_to_byte_array(ref result, 10);
                if result[result.len() - 2] == '.' {
                    result += "0";
                }

                result = ByteArrayTrait::concat(@ByteArrayTrait::concat(@op, @result), @cl);

                let mut extra = "";
                if result.len() < 13 {
                    let diff = 13 - result.len();
                    let mut i = 0;
                    while i < diff {
                        extra += " ";
                        i += 1;
                    }
                }

                formatted_change = ByteArrayTrait::concat(@extra, @result);
            } else {
                let mut result = " $ ";
                let mut i = 0;
                let mut op = "";
                let mut cl = "";
                if change[i] == '-' {
                    result = "  $ -";
                    i += 1;
                }
                op += " ";
                cl += " ";

                let mut int: u32 = 0;
                while i < change.len() {
                    let c = char_to_digit(change[i]);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; }
                    }
                    i += 1;
                };

                let val = int / 100;
                let mut temp = "";
                @val.append_formatted_to_byte_array(ref temp, 10);
                if temp.len() > 3 {
                    result.append_byte(temp[0]);
                    let mut i = 1;
                    let mut sep = 0;
                    while i < temp.len() {
                        if sep == 0 {
                            result.append_byte('.');
                            sep = 3;
                        }
                        result.append_byte(temp[i]);
                        i += 1;
                        sep -= 1;
                    }
                } else {
                    result += temp;
                }

                result += ",";
                let mut rem = int % 100;
                if int < 10 {
                    result += "0";
                }

                @rem.append_formatted_to_byte_array(ref result, 10);
                if result[result.len() - 2] == ',' {
                    result += "0";
                }

                result = ByteArrayTrait::concat(@ByteArrayTrait::concat(@op, @result), @cl);

                let mut extra = "";
                if result.len() < 13 {
                    let diff = 13 - result.len();
                    let mut i = 0;
                    while i < diff {
                        extra += " ";
                        i += 1;
                    }
                }

                formatted_change = ByteArrayTrait::concat(@extra, @result);
            }
        } else {
            if locale == Locale::en_US {
                // formatted_change = format_eur(change);

                let mut result = "e";
                let mut i = 0;
                let mut op = "";
                let mut cl = "";
                if change[i] == '-' {
                    op += "(";
                    cl += ")";
                    i += 1;
                } else {
                    op += " ";
                    cl += " ";
                }
                let mut int: u32 = 0;
                while i < change.len() {
                    let c = char_to_digit(change[i]);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; }
                    }
                    i += 1;
                };

                let val = int / 100;
                @val.append_formatted_to_byte_array(ref result, 10);
                result += ".";
                let rem = int % 100;
                if int < 10 {
                    result += "0";
                }
                @rem.append_formatted_to_byte_array(ref result, 10);

                if result[result.len() - 2] == '.' {
                    result += "0";
                }

                result = ByteArrayTrait::concat(@ByteArrayTrait::concat(@op, @result), @cl);

                let mut extra = "";
                if result.len() < 13 {
                    let diff = 13 - result.len();
                    let mut i = 0;
                    while i < diff {
                        extra += " ";
                        i += 1;
                    }
                }

                formatted_change = ByteArrayTrait::concat(@extra, @result);
            } else {
                // formatted_change = format_eur_nil(change);

                let mut result = "e ";
                let mut i = 0;
                let mut op = "";
                let mut cl = "";
                if change[i] == '-' {
                    op += "(";
                    cl += ")";
                    i += 1;
                } else {
                    op += " ";
                    cl += " ";
                }
                let mut int: u32 = 0;
                while i < change.len() {
                    let c = char_to_digit(change[i]);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; }
                    }
                    i += 1;
                };
                let val = int / 100;
                let mut temp = "";
                @val.append_formatted_to_byte_array(ref temp, 10);
                if temp.len() > 3 {
                    result.append_byte(temp[0]);
                    let mut i = 1;
                    let mut sep = 0;
                    while i < temp.len() {
                        if sep == 0 {
                            result.append_byte('.');
                            sep = 3;
                        }
                        result.append_byte(temp[i]);
                        i += 1;
                        sep -= 1;
                    }
                } else {
                    result += temp;
                }
                result += ",";
                let rem = int % 100;
                if int < 10 {
                    result += "0";
                }
                @rem.append_formatted_to_byte_array(ref result, 10);

                if result[result.len() - 2] == ',' {
                    result += "0";
                }

                result = ByteArrayTrait::concat(@ByteArrayTrait::concat(@op, @result), @cl);
                let mut extra = "";
                if result.len() < 13 {
                    let diff = 13 - result.len();
                    let mut i = 0;
                    while i < diff {
                        extra += " ";
                        i += 1;
                    }
                }

                formatted_change = ByteArrayTrait::concat(@extra, @result);
            }
        }

        let mut row = formatted_date;
        row += " | ";
        if transaction.len() > 22 {
            let mut i = 0;
            while i < 22 {
                row.append_byte(transaction[i]);
                i += 1;
            };
            row += "...";
        } else {
            row += transaction;
        }

        if row.len() < 38 {
            let dif = 38 - row.len();
            let mut i = 0;
            while i < dif {
                row += " ";
                i += 1;
            }
        }
        row += " | ";
        row += formatted_change;

        ledger.append(row);
    };

    ledger
}

fn char_to_digit(c: u8) -> Option<u8> {
    let zero_ascii = '0';
    let nine_ascii = '9';

    if c >= zero_ascii && c <= nine_ascii {
        Option::Some(c - zero_ascii)
    } else {
        Option::None // Return None for invalid characters
    }
}
