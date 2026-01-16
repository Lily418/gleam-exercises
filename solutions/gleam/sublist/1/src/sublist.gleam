pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

fn is_list_prefix(list_a: List(a), list_b: List(a)) {
  case list_a, list_b {
    [a, ..rest_a], [b, ..rest_b] if a == b -> is_list_prefix(rest_a, rest_b)
    [], _ -> True
    _, _ -> False
  }
}

fn contains_list(list_a: List(a), list_b: List(a)) -> Bool {
  case list_a, list_b {
    list_a, [b, ..rest_b] -> is_list_prefix(list_a, [b, ..rest_b]) || contains_list(list_a, rest_b)
    [], [] -> True
    _, _ -> False
  
  }
}

pub fn sublist(compare list_a: List(a), to list_b: List(a)) -> Comparison {
  let a_sublist_of_b = contains_list(list_a, list_b)
  let b_sublist_of_a = contains_list(list_b, list_a)

  case a_sublist_of_b, b_sublist_of_a {
    True, True -> Equal
    False, True -> Superlist
    True, False -> Sublist
    False, False -> Unequal
  }
}
