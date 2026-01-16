import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(e) = problem
  e
}

pub fn remove_team_prefix(team: String) -> String {
  let assert Ok(#(_a, b)) = string.split_once(team, "Team ") 
  b
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
    let assert Ok(#(a, b)) = string.split_once(combined, ",") 
    #(a, remove_team_prefix(b))

}
