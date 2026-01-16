// Please define the TreasureChest generic custom type
pub type TreasureChest(treasure) {
  TreasureChest(String, treasure)
}

// Please define the UnlockResult generic custom type
pub type UnlockResult(a) {
  Unlocked(a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(a, treasure) if a == password -> Unlocked(treasure)
    _ -> WrongPassword
  }
}
