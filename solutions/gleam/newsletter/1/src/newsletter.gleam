import simplifile
import gleam/string
import gleam/result
import gleam/list

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(from: path) {
    Ok(contents) -> {
      contents 
      |> string.trim()
      |> string.split("\n")
      |> Ok
    }
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  case simplifile.write("", to: path) {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  case simplifile.append(email <> "\n", to: path) {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  let _ = create_log_file(log_path)
          |> result.try(fn(_) { read_emails(emails_path) })
          |> result.try(fn(emails) { 
            list.map(emails, fn(email) {
              case send_email(email) {
                Ok(_) -> log_sent_email(log_path, email)
                Error(_) -> Error(Nil)
              }
            })
            |> result.all
          })
  Ok(Nil)
}
