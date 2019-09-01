(*
  Post-processing Options
 *)
type audio_format =
  | Aac
  | Best
  | Flac
  | Mp3
  | M4a
  | Opus
  | Vorbis
  | Wav

let show_audio_format = function
  | Aac -> "aac"
  | Best -> "best"
  | Flac -> "flac"
  | Mp3 -> "mp3"
  | M4a -> "m4a"
  | Opus -> "opus"
  | Vorbis -> "vorbis"
  | Wav -> "wav"

type post_process_option =
  | ExtractAudio
  | AudioFormat of audio_format
  | AudioQuality of int

let show_post_process_option = function
  | ExtractAudio -> "--extract-audio"
  | AudioFormat fmt -> "--audio-format " ^ show_audio_format fmt
  | AudioQuality i -> "--audio-quality " ^ string_of_int i

let show_post_process_options options = String.concat " " @@
  List.map show_post_process_option options

(*
  Filesystem Options
 *)
type output_path =
  | CustomPath of string
  | DefaultPath

let show_output_path = function
  | CustomPath path -> if path.[String.length path - 1] = '/'
    then path else path ^ "/"
  | DefaultPath -> ""

let show_output path tite =
  "--output \"" ^ show_output_path path ^ tite ^ "\" "

let default_title = "%(title)s.%(ext)s"
let default_options = [ExtractAudio; AudioFormat Mp3]
let default_path = CustomPath "/Volumes/lnbkup/ytdl_test"

let download_url url options output_path =
  let output_str = show_output output_path default_title  in
  let ppo_str = show_post_process_options options ^ " " in
  let cmd = "youtube-dl " ^ output_str ^ ppo_str ^ url in
  Sys.command cmd
