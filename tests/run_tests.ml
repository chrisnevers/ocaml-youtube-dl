let test_suites: unit Alcotest.test list = [
  "youtube_dl", Test_youtube_dl.tests
]

let () = Alcotest.run "youtube_dl" test_suites
