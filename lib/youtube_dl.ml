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
  Thumbnail Image Options
 *)
type thumbnail_image_option =
  | WriteThumbnail
  | WriteAllThumbnails
  | ListThumbnails

let show_thumbnail_image_option = function
  | WriteThumbnail -> "--write-thumbnail"
  | WriteAllThumbnails -> "--write-all-thumbnails"
  | ListThumbnails -> "--list-thumbnails"

let show_thumbnail_image_options options = String.concat " " @@
  List.map show_thumbnail_image_option options

(*
  Template Options
 *)
type string_template =
  (* Video identifier *)
  | TemplateId
  (* Video title *)
  | TemplateTitle
  (* Video URL *)
  | TemplateUrl
  (* Video filename extension *)
  | TemplateExt
  (* A secondary title of the video *)
  | TemplateAltTitle
  (* An alternative identifier for the video *)
  | TemplateDisplayId
  (* Full name of the video uploader *)
  | TemplateUploader
  (* License name the video is licensed under *)
  | TemplateLicense
  (* The creator of the video *)
  | TemplateCreator
  (* The date (YYYYMMDD) when the video was released *)
  | TemplateReleaseDate
  (* Video upload date (YYYYMMDD) *)
  | TemplateUploadDate
  (* Nickname or id of the video uploader *)
  | TemplateUploaderId
  (* Full name of the channel the video is uploaded on *)
  | TemplateChannel
  (* Id of the channel *)
  | TemplateChannelId
  (* Physical location where the video was filmed *)
  | TemplateLocation
  (* Title of the track *)
  | TemplateTrack
  (* Id of the track *)
  | TemplateTrackId
  (* Artist(s) of the track *)
  | TemplateArtist
  (* Genre(s) of the track *)
  | TemplateGenre
  (* Title of the album the track belongs to *)
  | TemplateAlbum
  (* Type of the album *)
  | TemplateAlbumType
  (* List of all artists appeared on the album *)
  | TemplateAlbumArtist

let show_string_template = function
  | TemplateId -> "id"
  | TemplateTitle -> "title"
  | TemplateUrl -> "url"
  | TemplateExt -> "ext"
  | TemplateAltTitle -> "alt_title"
  | TemplateDisplayId -> "display_id"
  | TemplateUploader -> "uploader"
  | TemplateLicense -> "licensed"
  | TemplateCreator -> "creator"
  | TemplateReleaseDate -> "release_date"
  | TemplateUploadDate -> "upload_date"
  | TemplateUploaderId -> "uploader_id"
  | TemplateChannel -> "channel"
  | TemplateChannelId -> "channel_id"
  | TemplateLocation -> "location"
  | TemplateTrack -> "track"
  | TemplateTrackId -> "track_id"
  | TemplateArtist -> "artist"
  | TemplateGenre -> "genre"
  | TemplateAlbum -> "album"
  | TemplateAlbumType -> "album_type"
  | TemplateAlbumArtist -> "album_artist"

type numeric_template =
  (* UNIX timestamp of the moment the video became available *)
  | TemplateTimestamp
  (* Length of the video in seconds *)
  | TemplateDuration
  (* How many users have watched the video on the platform *)
  | TemplateViewCount
  (* Number of positive ratings of the video *)
  | TemplateLikeCount
  (* Number of negative ratings of the video *)
  | TemplateDislikeCount
  (* Number of reposts of the video *)
  | TemplateRepostCount
  (* Average rating given by users, the scale used depends on the webpage *)
  | TemplateAverageRating
  (* Number of the track within an album or a disc *)
  | TemplateTrackNumber
  (* Number of the disc or other physical medium the track belongs to *)
  | TemplateDiscNumber
  (* Year (YYYY) when the album was released *)
  | TemplateReleaseYear

let show_numeric_template = function
  | TemplateTimestamp -> "timestamp"
  | TemplateDuration -> "duration"
  | TemplateViewCount -> "view_count"
  | TemplateLikeCount -> "like_count"
  | TemplateDislikeCount -> "dislike_count"
  | TemplateRepostCount -> "repost_count"
  | TemplateAverageRating -> "average_rating"
  | TemplateTrackNumber -> "track_number"
  | TemplateDiscNumber -> "disc_number"
  | TemplateReleaseYear -> "release_year"

type template_option =
  | Text of string
  | StringTemplate of string_template
  | NumericTemplate of numeric_template * int

let show_template_option = function
  | Text str -> str
  | StringTemplate tmp -> "%(" ^ show_string_template tmp ^ ")s"
  | NumericTemplate (tmp, i) -> "%(" ^ show_numeric_template tmp ^ ")"
    ^ string_of_int i ^ "d"

let show_template_options options = String.concat "" @@
  List.map show_template_option options

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

type filesystem_option =
  (* Todo: Make this template *)
  | Output of output_path * template_option list
  | BatchFile of string
  | RestrictFileNames
  | NoOverwrites
  | WriteDescription
  | WriteInfoJson
  | WriteAnnotations
  | CacheDir of string
  | NoCacheDir
  | RmCacheDir

let show_filesystem_option = function
  | Output (path, template) -> "--output \"" ^ show_output_path path
    ^ show_template_options template ^ "\""
  | BatchFile file -> "--batch-file " ^ file
  | RestrictFileNames -> "--restrict-filenames"
  | NoOverwrites -> "--no-overwrites"
  | WriteDescription -> "--write-description"
  | WriteInfoJson -> "--write-info-json"
  | WriteAnnotations -> "--write-annotations"
  | CacheDir dir -> "--cache-dir " ^ dir
  | NoCacheDir -> "--no-cache-dir"
  | RmCacheDir -> "--rm-cache-dir"

let show_filesystem_options options = String.concat " " @@
  List.map show_filesystem_option options

let default_title = [
  StringTemplate TemplateTitle; Text "."; StringTemplate TemplateExt
]
let default_options = [ExtractAudio; AudioFormat Mp3]
let default_path = CustomPath "/Volumes/lnbkup/ytdl_test"

let download_url url post_process_options filesystem_options =
  let output_str = show_filesystem_options filesystem_options in
  let ppo_str = show_post_process_options post_process_options ^ " " in
  let cmd = "youtube-dl " ^ output_str ^ " " ^ ppo_str ^ url in
  Sys.command cmd
