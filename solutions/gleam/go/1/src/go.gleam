import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  let result = rule1(game)
  |> result.map(fn(g) { rule2(g) })
  |> result.try(fn(g) { rule3(g) })
  |> result.try(fn(g) { rule4(g) })
  case result {
    Ok(g) if g.player == Black -> Game(g.white_captured_stones, g.black_captured_stones, White, g.error)
    Ok(g) -> Game(g.white_captured_stones, g.black_captured_stones, Black, g.error)
    Error(e) -> Game(game.white_captured_stones, game.black_captured_stones, game.player, e)
  }

}
