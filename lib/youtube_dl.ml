
let download_url url =
  Sys.command("youtube-dl -o \"/Volumes/lnbkup/ytdl_test/%(title)s.%(ext)s\" --extract-audio --audio-format \"mp3\" " ^ url)
