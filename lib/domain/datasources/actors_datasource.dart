
import 'package:movies/domain/entities/actor.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getMovieActors( String movieId );
}