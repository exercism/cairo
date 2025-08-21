/// Essence - a rare magical ingredient with potency
#[derive(Drop)]
pub struct Essence {
    pub potency: u16,
}

/// Elixir - a refined magical ingredient with strength
#[derive(Drop)]
pub struct Elixir {
    pub strength: u16,
}

/// Convert signed integer to unsigned integer (if possible)
pub fn convert_signed_to_unsigned(value: i32) -> Option<u16> {
    value.try_into()
}

/// Convert unsigned integer to signed integer
pub fn convert_unsigned_to_signed(value: u16) -> i32 {
    value.into()
}

/// Convert Essence to Elixir using the Into trait
pub fn convert_essence_to_elixir(essence: Essence) -> Elixir {
    essence.into()
}

impl EssenceIntoElixir of Into<Essence, Elixir> {
    fn into(self: Essence) -> Elixir {
        Elixir { strength: self.potency }
    }
}
