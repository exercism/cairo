#[derive(Drop)]
pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

#[generate_trait]
pub impl PlayerImpl of PlayerTrait {
    fn revive(self: @Player) -> Option<Player> {
        panic!("Revive this player")
    }

    fn cast_spell(ref self: Player, mana_cost: u32) -> u32 {
        panic!("Cast a spell of cost {mana_cost}")
    }
}
