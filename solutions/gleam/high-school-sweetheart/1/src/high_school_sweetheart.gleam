import gleam/string

pub fn first_letter(name: String) {
  case string.first(string.trim(name)) {
    Ok(l) -> l
    Error(_) -> ""
  }
}

pub fn initial(name: String) {
  string.uppercase(first_letter(name)) <> "."
}

pub fn initials(full_name: String) {
  case string.split_once(full_name, " ") {
    Ok(#(first, last)) -> initial(first) <> " " <> initial(last)
    Error(_) -> ""
  }
}

pub fn pair(_full_name1: String, _full_name2: String) {
"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     A. B.  +  C. D.     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
