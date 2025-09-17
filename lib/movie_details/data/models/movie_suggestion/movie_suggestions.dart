import 'dart:convert';

MovieSuggestions movieSuggestionsFromJson(String str) =>
    MovieSuggestions.fromJson(json.decode(str));

String movieSuggestionsToJson(MovieSuggestions data) =>
    json.encode(data.toJson());

class MovieSuggestions {
  MovieSuggestions({
    required this.statusMessage,
    required this.data,
    required this.meta,
    required this.status,
  });

  String statusMessage;
  Data data;
  Meta meta;
  String status;

  factory MovieSuggestions.fromJson(Map<dynamic, dynamic> json) =>
      MovieSuggestions(
        statusMessage: json["status_message"],
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["@meta"]),
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
    "status_message": statusMessage,
    "data": data.toJson(),
    "@meta": meta.toJson(),
    "status": status,
  };
}

class Data {
  Data({required this.movies, required this.movieCount});

  List<Movie> movies;
  int movieCount;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
    movieCount: json["movie_count"],
  );

  Map<dynamic, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "movie_count": movieCount,
  };
}

class Movie {
  Movie({
    required this.smallCoverImage,
    required this.year,
    required this.descriptionFull,
    required this.rating,
    required this.titleLong,
    required this.language,
    required this.ytTrailerCode,
    required this.title,
    required this.mpaRating,
    required this.genres,
    required this.titleEnglish,
    required this.id,
    required this.state,
    required this.slug,
    required this.summary,
    required this.dateUploaded,
    required this.runtime,
    required this.synopsis,
    required this.url,
    required this.imdbCode,
    required this.backgroundImage,
    required this.torrents,
    required this.dateUploadedUnix,
    required this.backgroundImageOriginal,
    required this.mediumCoverImage,
  });

  String smallCoverImage;
  int year;
  String descriptionFull;
  double rating;
  String titleLong;
  String language;
  String ytTrailerCode;
  String title;
  String mpaRating;
  List<String> genres;
  String titleEnglish;
  int id;
  String state;
  String slug;
  String summary;
  DateTime dateUploaded;
  int runtime;
  String synopsis;
  String url;
  String imdbCode;
  String backgroundImage;
  List<Torrent> torrents;
  int dateUploadedUnix;
  String backgroundImageOriginal;
  String mediumCoverImage;

  factory Movie.fromJson(Map<dynamic, dynamic> json) => Movie(
    smallCoverImage: json["small_cover_image"],
    year: json["year"],
    descriptionFull: json["description_full"],
    rating: json["rating"]?.toDouble(),
    titleLong: json["title_long"],
    language: json["language"],
    ytTrailerCode: json["yt_trailer_code"],
    title: json["title"],
    mpaRating: json["mpa_rating"],
    genres: List<String>.from(json["genres"].map((x) => x)),
    titleEnglish: json["title_english"],
    id: json["id"],
    state: json["state"],
    slug: json["slug"],
    summary: json["summary"],
    dateUploaded: DateTime.parse(json["date_uploaded"]),
    runtime: json["runtime"],
    synopsis: json["synopsis"],
    url: json["url"],
    imdbCode: json["imdb_code"],
    backgroundImage: json["background_image"],
    torrents: List<Torrent>.from(
      json["torrents"].map((x) => Torrent.fromJson(x)),
    ),
    dateUploadedUnix: json["date_uploaded_unix"],
    backgroundImageOriginal: json["background_image_original"],
    mediumCoverImage: json["medium_cover_image"],
  );

  Map<dynamic, dynamic> toJson() => {
    "small_cover_image": smallCoverImage,
    "year": year,
    "description_full": descriptionFull,
    "rating": rating,
    "title_long": titleLong,
    "language": language,
    "yt_trailer_code": ytTrailerCode,
    "title": title,
    "mpa_rating": mpaRating,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "title_english": titleEnglish,
    "id": id,
    "state": state,
    "slug": slug,
    "summary": summary,
    "date_uploaded": dateUploaded.toIso8601String(),
    "runtime": runtime,
    "synopsis": synopsis,
    "url": url,
    "imdb_code": imdbCode,
    "background_image": backgroundImage,
    "torrents": List<dynamic>.from(torrents.map((x) => x.toJson())),
    "date_uploaded_unix": dateUploadedUnix,
    "background_image_original": backgroundImageOriginal,
    "medium_cover_image": mediumCoverImage,
  };
}

class Torrent {
  Torrent({
    required this.videoCodec,
    required this.sizeBytes,
    required this.seeds,
    required this.audioChannels,
    required this.dateUploaded,
    required this.peers,
    required this.url,
    required this.quality,
    required this.size,
    required this.isRepack,
    required this.dateUploadedUnix,
    required this.bitDepth,
    required this.hash,
  });

  String videoCodec;
  int sizeBytes;
  int seeds;
  String audioChannels;
  DateTime dateUploaded;
  int peers;
  String url;
  String quality;
  String size;
  String isRepack;
  int dateUploadedUnix;
  String bitDepth;
  String hash;

  factory Torrent.fromJson(Map<dynamic, dynamic> json) => Torrent(
    videoCodec: json["video_codec"],
    sizeBytes: json["size_bytes"],
    seeds: json["seeds"],
    audioChannels: json["audio_channels"],
    dateUploaded: DateTime.parse(json["date_uploaded"]),
    peers: json["peers"],
    url: json["url"],
    quality: json["quality"],
    size: json["size"],
    isRepack: json["is_repack"],
    dateUploadedUnix: json["date_uploaded_unix"],
    bitDepth: json["bit_depth"],
    hash: json["hash"],
  );

  Map<dynamic, dynamic> toJson() => {
    "video_codec": videoCodec,
    "size_bytes": sizeBytes,
    "seeds": seeds,
    "audio_channels": audioChannels,
    "date_uploaded": dateUploaded.toIso8601String(),
    "peers": peers,
    "url": url,
    "quality": quality,
    "size": size,
    "is_repack": isRepack,
    "date_uploaded_unix": dateUploadedUnix,
    "bit_depth": bitDepth,
    "hash": hash,
  };
}

class Meta {
  Meta({
    required this.serverTime,
    required this.serverTimezone,
    required this.apiVersion,
    required this.executionTime,
  });

  int serverTime;
  String serverTimezone;
  int apiVersion;
  String executionTime;

  factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
    serverTime: json["server_time"],
    serverTimezone: json["server_timezone"],
    apiVersion: json["api_version"],
    executionTime: json["execution_time"],
  );

  Map<dynamic, dynamic> toJson() => {
    "server_time": serverTime,
    "server_timezone": serverTimezone,
    "api_version": apiVersion,
    "execution_time": executionTime,
  };
}
