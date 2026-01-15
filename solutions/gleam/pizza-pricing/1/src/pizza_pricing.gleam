import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}



pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> 1 + pizza_price(p)
    ExtraToppings(p) -> 2 + pizza_price(p)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let pizza_price = list.fold(order, 0, fn(acc, p) { acc + pizza_price(p) })
  case order {
    [] -> 0
    [_x] -> 3 + pizza_price
    [_x,_y] -> 2 + pizza_price
    _ -> pizza_price
  }
}
