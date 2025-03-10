
import 'package:dio/dio.dart';
import 'package:movies/config/constants/enviroments.dart';
import 'package:movies/domain/datasources/movies_datasource.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/infrastructure/mappers/movie_mapper.dart';
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

}