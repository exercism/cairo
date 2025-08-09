#[derive(Drop)]
pub struct Essence {
    pub potency: u16,
}

#[derive(Drop)]
pub struct Elixir {
    pub strength: u16,
}

pub fn convert_signed_to_unsigned(value: i32) -> Option<u16> {
    if value < 0 {
        Option::None
    } else {
        match value.try_into() {
            Option::Some(v) => Option::Some(v),
            Option::None => Option::None,
        }
    }
}

pub fn convert_unsigned_to_signed(value: u16) -> i32 {
    value.into()
}

pub fn convert_essence_to_elixir(essence: Essence) -> Elixir {
    essence.into()
}

impl EssenceIntoElixir of Into<Essence, Elixir> {
    fn into(self: Essence) -> Elixir {
        Elixir { strength: self.potency }
    }
}
