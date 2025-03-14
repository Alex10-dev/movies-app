
import 'package:movies/domain/datasources/movies_datasource.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImp extends MoviesRepository {

  final MoviesDatasource datasource;

  MoviesRepositoryImp({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> executeGetUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> executeGetMovieById({required String id}) {
    return datasource.getMovieById(id: id);
  }
}