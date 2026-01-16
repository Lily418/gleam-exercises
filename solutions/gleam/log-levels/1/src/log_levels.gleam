import gleam/string

pub fn message(log_line: String) -> String {
  let message = case log_line {
    "[INFO]:" <> x -> x
    "[WARNING]:" <> x -> x
    "[ERROR]:" <> x -> x
    _ -> panic
  }
  string.trim(message)
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]" <> _ -> "info"
    "[WARNING]" <> _ -> "warning"
    "[ERROR]" <> _ -> "error"
    _ -> panic
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " " <> "(" <> log_level(log_line) <> ")"
}
