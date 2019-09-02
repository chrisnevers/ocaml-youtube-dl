open Alcotest
open Youtube_dl

let url = "https://www.youtube.com/watch?v=pK94lt1VUig"

let download_url_test () =
  let post_process_options = [ExtractAudio; AudioFormat Mp3] in
  let filesystem_options = [Output (CustomPath "/Volumes/lnbkup/ytdl_test", default_title)] in
  (check (int)) "download_url" 0
    (download_url url post_process_options filesystem_options)

let tests = [
  "download_url", `Quick, download_url_test
]
