
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/video.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> executeGetUpcoming({ int page = 1 });

  Future<Movie> executeGetMovieById({ required String id });

  Future<List<Movie>> executeGetRelatedMovies({ int page = 1, String id  = '1000' });

  Future<List<Video>> executeGetMovieVideos({ required String id });

  Future<List<Movie>> executeSearchMovies( String query );
}