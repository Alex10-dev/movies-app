
import 'package:movies/domain/datasources/actors_datasource.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/domain/repositories/actors_repository.dart';

class ActorsRepositoryImp extends ActorsRepository {

   final ActorsDatasource datasource;

   ActorsRepositoryImp({ required this.datasource });

  @override
  Future<List<Actor>> getMovieActors(String movieId) {
    return datasource.getMovieActors(movieId);
  }
}