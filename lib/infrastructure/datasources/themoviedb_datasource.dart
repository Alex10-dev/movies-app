
import 'package:dio/dio.dart';
import 'package:movies/config/constants/enviroments.dart';
import 'package:movies/domain/datasources/movies_datasource.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/video.dart';
import 'package:movies/infrastructure/mappers/movie_mapper.dart';
import 'package:movies/infrastructure/mappers/video_mapper.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_details_response.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_video_reponse.dart';
import 'package:movies/infrastructure/models/themoviedb/recommended_movies_response.dart';
import 'package:movies/infrastructure/models/themoviedb/themoviedb_response.dart';

class ThemoviedbDatasource extends MoviesDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Enviroments.movieDBApiKey,
        'language': 'es-MX'
      }
    )
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );
    
    //este fromJson es del objeto que obtuvimos de quicktype io, tal cual nos responde el api
    final TheMovieDbResponse theMovieDBResponse = TheMovieDbResponse.fromJson( response.data );

    //recorremos cada elemento de la respuesta http y usamos el mapper para pasar la info
    //a nuestra entidad particular
    final List<Movie> movies = theMovieDBResponse.results
    .where((moviedb) => moviedb.posterPath != '')
    .where((moviedb) => moviedb.backdropPath != '')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final response = await dio.get('/movie/popular', 
      queryParameters: {
        'page': page
      }
    );
    
    //este fromJson es del objeto que obtuvimos de quicktype io, tal cual nos responde el api
    final TheMovieDbResponse theMovieDBResponse = TheMovieDbResponse.fromJson( response.data );

    //recorremos cada elemento de la respuesta http y usamos el mapper para pasar la info
    //a nuestra entidad particular
    final List<Movie> movies = theMovieDBResponse.results
    .where((moviedb) => moviedb.posterPath != '')
    .where((moviedb) => moviedb.backdropPath != '')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<List<Movie>> getUpcoming({ int page = 1 }) async{
    final response = await dio.get('/movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );
    
    final TheMovieDbResponse theMovieDBResponse = TheMovieDbResponse.fromJson( response.data );

    final List<Movie> movies = theMovieDBResponse.results
    .where((moviedb) => moviedb.posterPath != '')
    .where((moviedb) => moviedb.backdropPath != '')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }
  
  @override
  Future<Movie> getMovieById({ required String id }) async{
    final response = await dio.get('/movie/$id');

    if( response.statusCode != 200 ) throw Exception('Movie with id: $id not found');

    final MovieDetailsResponse movieDetails = MovieDetailsResponse.fromJson( response.data );

    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
  
  @override
  Future<List<Movie>> getRelatedMovies({int page = 1, String id = '1000'}) async{
    final response = await dio.get('/movie/$id/recommendations', 
      queryParameters: {
        'page': page
      }
    );

    final RecommendedMoviesResponse recommendedMoviesResponse = RecommendedMoviesResponse.fromJson( response.data );

    final List<Movie> movies = recommendedMoviesResponse.results
    .map(
      (movieDb) => MovieMapper.movieDBToEntity(movieDb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Video>> getMovieVideos({required String id}) async{
    final response = await dio.get('/movie/$id/videos');

    final MovieVideoResponse movieVideosReponse = MovieVideoResponse.fromJson( response.data );
    
    final List<Video> videos = movieVideosReponse.results
    .map(
      (videoDb) => VideoMapper.videoInfoToEntity( videoDb )
    ).toList();

    return videos;
  }
  
  

}