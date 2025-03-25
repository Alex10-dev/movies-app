
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/infrastructure/models/themoviedb/movie_credits_reponse.dart';

class ActorMapper {
  static Actor castToActorEntity( Cast movieCast ) => Actor(
    id: movieCast.id, 
    name: movieCast.name, 
    profilePath: movieCast.profilePath == null 
      ? 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg'
      : 'https://image.tmdb.org/t/p/w500${movieCast.profilePath!}', 
    character: movieCast.character,
  );
}