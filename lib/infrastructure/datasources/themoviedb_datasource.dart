
import 'package:dio/dio.dart';
import 'package:movies/config/constants/enviroments.dart';
import 'package:movies/domain/datasources/movies_datasource.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/infrastructure/mappers/movie_mapper.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_details_response.dart';
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
    final List<Movie> movies = theMovieDBResponse.results.map(
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
    .where((moviedb) => moviedb.posterPath != 'no-poster')
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
    .where((moviedb) => moviedb.posterPath != 'no-poster')
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

}