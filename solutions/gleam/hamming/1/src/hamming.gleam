import gleam/list
import gleam/string
import gleam/result.{map}

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  let list1 = string.split(strand1, "")
  let list2 = string.split(strand2, "")
  list.strict_zip(list1, list2)
  |> map(fn(lists) {
      list.fold(lists, 0, fn(acc, x) { 
          case x.0 == x.1 {
            True -> acc
            False -> acc + 1
        }
      })
    })
}
