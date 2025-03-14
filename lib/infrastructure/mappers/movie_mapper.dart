import 'package:movies/domain/entities/movie.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_details_response.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB movieDB) => Movie(
    isForAdult: movieDB.adult,
    backdropLink: movieDB.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
    genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
    id: movieDB.id,
    originalLanguage: movieDB.originalLanguage,
    originalTitle: movieDB.originalTitle,
    overview: movieDB.overview,
    popularity: movieDB.popularity,
    posterLink: movieDB.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
    releaseDate: movieDB.releaseDate,
    title: movieDB.title,
    hasVideo: movieDB.video,
    voteAverage: movieDB.voteAverage,
    voteCount: movieDB.voteCount
  );

  static Movie movieDetailsToEntity( MovieDetailsResponse movieDB ) => Movie(
    isForAdult: movieDB.adult,
    backdropLink: movieDB.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500${movieDB.backdropPath}'
      : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
    genreIds: movieDB.genres.map((e) => e.name).toList(),
    id: movieDB.id,
    originalLanguage: movieDB.originalLanguage,
    originalTitle: movieDB.originalTitle,
    overview: movieDB.overview,
    popularity: movieDB.popularity,
    posterLink: movieDB.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500${movieDB.posterPath}'
      : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
    releaseDate: movieDB.releaseDate,
    title: movieDB.title,
    hasVideo: movieDB.video,
    voteAverage: movieDB.voteAverage,
    voteCount: movieDB.voteCount
  );
}
