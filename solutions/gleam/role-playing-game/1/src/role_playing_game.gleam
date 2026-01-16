import gleam/option.{type Option}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    option.None -> "Mighty Magician"
    option.Some(name) -> name
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health, player.level {
    health, _ if health > 0 -> option.None
    health, level if level >= 10 -> option.Some(Player(..player, health: 100, mana: option.Some(100)))
    _, _ -> option.Some(Player(..player, health: 100))
  }
}

fn decrease_health(starting_health: Int, damage: Int) -> Int {
  case damage > starting_health {
    True -> 0
    False -> starting_health - damage
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    option.Some(mana) if mana >= cost -> #(Player(..player, mana: option.Some(mana - cost)), cost * 2)
    option.Some(mana) -> #(player, 0)
    option.None -> #(Player(..player, health: decrease_health(player.health, cost)), 0)

  }
}
