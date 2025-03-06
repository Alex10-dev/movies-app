class Movie {
  final bool isForAdult;
  final String backdropLink;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterLink;
  final DateTime releaseDate;
  final String title;
  final bool hasVideo;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.isForAdult,
    required this.backdropLink,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterLink,
    required this.releaseDate,
    required this.title,
    required this.hasVideo,
    required this.voteAverage,
    required this.voteCount
  });
}