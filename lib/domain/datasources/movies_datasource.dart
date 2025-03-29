
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/video.dart';

abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1});

  Future<List<Movie>> getUpcoming({ int page = 1 });

  Future<Movie> getMovieById({ required String id });

  Future<List<Movie>> getRelatedMovies({ int page = 1, String id = '1000' });

  Future<List<Video>> getMovieVideos({ required String id });

  Future<List<Movie>> searchMovies( String query );
}