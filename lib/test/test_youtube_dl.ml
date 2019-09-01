open Alcotest
open Youtube_dl

let get_string_test () =
  (check (string)) "get_string" "Hello" (get_string ())

let tests = [
  "get_string", `Quick, get_string_test
]
