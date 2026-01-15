import exercism/test_runner.{ debug }
import gleam/int

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine  -> 0b00
    Cytosine -> 0b01
    Guanine  -> 0b10
    Thymine  -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  case dna {
    [] -> <<>>
    [head, ..tail] -> <<encode_nucleotide(head):2, encode(tail):bits>>
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<value: 0>> -> Ok([])
    <<value: 2, rest:bits>> ->  {
      case decode_nucleotide(value), decode(rest) {
        Ok(n), Ok(l) -> Ok([n, ..l])
        _, _ -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
