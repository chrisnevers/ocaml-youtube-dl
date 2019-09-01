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
