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

#[derive(Debug, PartialEq, Drop)]
pub struct Entry {
    pub date: ByteArray,
    pub description: ByteArray,
    pub amount_in_cents: i32,
}

pub fn format_entries(
    currency: Currency, locale: Locale, entries: Array<Entry>,
) -> Array<ByteArray> {
    let mut ledger: Array<ByteArray> = ArrayTrait::new();
    let mut header = "";
    if locale == Locale::en_US {
        header = "Date       | Description               | Change       ";
    } else if locale == Locale::nl_NL {
        header = "Datum      | Omschrijving              | Verandering  ";
    }
    // date, transaction, change
    ledger.append(header);
    for entry in entries {
        let mut formatted_date = "";
        if locale == Locale::en_US {
            let mut year = "/";
            let mut month = "";
            let mut day = "/";

            let mut i = 0;
            let mut sep = 0;

            while i < entry.date.len() {
                if sep == 0 && i < 4 && entry.date[i] != '-' {
                    year.append_byte(entry.date[i]);
                } else if entry.date[i] == '-' {
                    sep += 1;
                } else if sep == 1 && i < 7 && entry.date[i] != '-' {
                    month.append_byte(entry.date[i]);
                } else {
                    day.append_byte(entry.date[i]);
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

            while i < entry.date.len() {
                if sep == 0 && i < 4 && entry.date[i] != '-' {
                    year.append_byte(entry.date[i]);
                } else if entry.date[i] == '-' {
                    sep += 1;
                } else if sep == 1 && i < 7 && entry.date[i] != '-' {
                    month.append_byte(entry.date[i]);
                } else {
                    day.append_byte(entry.date[i]);
                }
                i += 1;
            };

            formatted_date = ByteArrayTrait::concat(@day, @ByteArrayTrait::concat(@month, @year));
        }

        let mut formatted_change = "";
        let amount_in_cents = entry.amount_in_cents;
        let change = format!("{amount_in_cents}");
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
                    let zero_ascii = '0';
                    let c = Option::Some(change[i] - zero_ascii);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; },
                    }
                    i += 1;
                };

                let val = int / 100;
                let mut temp = format!("{val}");
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

                let rem = format!("{rem}");
                result += rem;
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
                    let zero_ascii = '0';
                    let c = Option::Some(change[i] - zero_ascii);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; },
                    }
                    i += 1;
                };

                let val = int / 100;
                let mut temp = format!("{val}");
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

                let rem = format!("{rem}");
                result += rem;
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
                    let zero_ascii = '0';
                    let c = Option::Some(change[i] - zero_ascii);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; },
                    }
                    i += 1;
                };

                let val = int / 100;
                let val = format!("{val}");
                result += val;
                result += ".";
                let rem = int % 100;
                if int < 10 {
                    result += "0";
                }
                let mut rem = format!("{rem}");
                if rem.len() < 2 {
                    rem += "0";
                }
                result += rem;

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
                    let zero_ascii = '0';
                    let c = Option::Some(change[i] - zero_ascii);

                    match c {
                        Option::Some(v) => { int = int * 10 + v.into(); },
                        Option::None => { break; },
                    }
                    i += 1;
                };
                let val = int / 100;
                let mut temp = format!("{val}");
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
                let mut rem = format!("{rem}");
                if rem.len() < 2 && int >= 10 {
                    rem += "0";
                }
                result += rem;

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
        if entry.description.len() > 22 {
            let mut i = 0;
            while i < 22 {
                row.append_byte(entry.description[i]);
                i += 1;
            };
            row += "...";
        } else {
            row += entry.description;
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
