
import 'package:movies/domain/entities/movie.dart';

abstract class LocalStorageDatasource {

  Future<void> toggleFavorite( Movie movie );

  Future<bool> isMovieFavorite( int movieId );

  Future<List<Movie>> loadFavoriteMovies({ int limit = 10, int offset = 0});
}