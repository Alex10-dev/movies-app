import 'package:movies/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> executeToggleFavorite( Movie movie );

  Future<bool> executeIsMovieFavorite( int movieId );

  Future<List<Movie>> executeLoadFavoriteMovies({ int limit = 10, int offset = 0});
}