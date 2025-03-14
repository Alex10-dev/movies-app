
import 'package:dio/dio.dart';
import 'package:movies/config/constants/enviroments.dart';
import 'package:movies/domain/datasources/actors_datasource.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/infrastructure/mappers/actor_mapper.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_credits_reponse.dart';

class ActorThemoviedbDatasource extends ActorsDatasource {

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
  Future<List<Actor>> getMovieActors(String movieId) async{

    final response = await dio.get('/movie/$movieId/credits');

    final MovieCreditsResponse credits = MovieCreditsResponse.fromJson( response.data );

    List<Actor> actors = credits.cast.map(
      ( cast ) => ActorMapper.castToActorEntity(cast)
    ).toList();

    return actors;
  }

}