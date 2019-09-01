open Alcotest
open Youtube_dl

let url = "https://www.youtube.com/watch?v=pK94lt1VUig"

let download_url_test () =
  (check (int)) "download_url" 0 (download_url url)

let tests = [
  "download_url", `Quick, download_url_test
]
