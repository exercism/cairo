#[derive(Drop)]
pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

#[generate_trait]
pub impl PlayerImpl of PlayerTrait {
    fn revive(self: @Player) -> Option<Player> {
        if *self.health == 0 {
            Option::Some(
                Player {
                    health: 100,
                    level: *self.level,
                    mana: if *self.level >= 10 {
                        Option::Some(100)
                    } else {
                        Option::None
                    },
                },
            )
        } else {
            // reviving a player who isn't dead has no effect
            Option::None
        }
    }

    fn cast_spell(ref self: Player, mana_cost: u32) -> u32 {
        match self.mana {
            Option::Some(m) => {
                if m >= mana_cost {
                    self.mana = Option::Some(m - mana_cost);
                    mana_cost * 2
                } else {
                    0
                }
            },
            Option::None => {
                if self.health < mana_cost {
                    self.health = 0;
                } else {
                    self.health -= mana_cost;
                }
                0
            },
        }
    }
}
