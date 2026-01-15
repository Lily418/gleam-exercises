import gleam/set.{type Set, from_list, to_list, contains, insert, delete, intersection, union, size, filter}
import gleam/list
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  let in_collection = contains(collection, card)
  let collection_with_card = insert(collection, card)
  #(in_collection, collection_with_card)
}

pub fn make_trade(my_card: String, their_card: String, collection: Set(String)) -> Set(String) {
  collection |> delete(my_card) |> insert(their_card) 
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let have_card = contains(collection, my_card)
  let need_their_card = !contains(collection, their_card)
  let trade_result = make_trade(my_card, their_card, collection)
  case have_card, need_their_card {
    True, True -> { 
      #(True, trade_result)
      }
    _, _ -> #(False, trade_result)
  }
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  let cards = list.reduce(collections, fn(a, b) { intersection(a, b) })
  case cards {
    Ok(x) -> to_list(x)
    Error(_) -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  let all_cards = list.reduce(collections, fn(a, b) { union(a, b) })
  case all_cards {
    Ok(x) -> size(x)
    Error(_) -> 0
  }
  
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  filter(collection, fn(x) {
    string.starts_with(x, "Shiny ")
  })
}
