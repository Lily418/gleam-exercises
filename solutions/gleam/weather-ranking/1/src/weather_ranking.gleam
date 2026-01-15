import gleam/order.{type Order}
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Fahrenheit(x), y ->  compare_temperature(Celsius(fahrenheit_to_celsius(x)), y)
    x, Fahrenheit(y) -> compare_temperature(x, Celsius(fahrenheit_to_celsius(y)))
    Celsius(x), Celsius(y) if x >. y -> order.Gt
    Celsius(x), Celsius(y) if x <. y -> order.Lt
    _, _ -> order.Eq

  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, fn(c1, c2) { compare_temperature(c1.temperature, c2.temperature) })
}
