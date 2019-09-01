open Alcotest
open Youtube_dl

let url = "https://www.youtube.com/watch?v=pK94lt1VUig"

let download_url_test () =
  let options = [ExtractAudio; AudioFormat Mp3] in
  let path = CustomPath "/Volumes/lnbkup/ytdl_test" in
  (check (int)) "download_url" 0 (download_url url options path)

let tests = [
  "download_url", `Quick, download_url_test
]
