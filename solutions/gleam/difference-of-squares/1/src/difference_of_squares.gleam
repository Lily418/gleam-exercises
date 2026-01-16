import gleam/int
import gleam/float

fn sum_nat(n: Int) -> Int {
  case n {
    1 -> 1
    n -> n + sum_nat(n-1)
  }
}

pub fn square_of_sum(n: Int) -> Int {
    let assert Ok(x) = int.power(sum_nat(n), 2.0)
    float.truncate(x)
}

pub fn sum_of_squares(n: Int) -> Int {
  case n {
    1 -> 1
    n -> {
      let assert Ok(x) = int.power(n, 2.0)
      float.truncate(x) + sum_of_squares(n-1) 
    }
  }
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
