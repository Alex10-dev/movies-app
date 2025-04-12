import 'package:movies/domain/datasources/local_storage_datasource.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImp extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImp({ required this.datasource });

  @override
  Future<bool> executeIsMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> executeLoadFavoriteMovies({int limit = 10, int offset = 0}) {
    return datasource.loadFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> executeToggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}