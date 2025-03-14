

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/presentation/providers/actors/actors_repository_provider.dart';

final movieActorsProvider = StateNotifierProvider<MovieActorsNotifier, Map<String, List<Actor>>>((ref) {

  final actorsRepository = ref.watch( actorsRepositoryProvider );

  return MovieActorsNotifier( getMovieActors: actorsRepository.getMovieActors );
});

typedef GetMovieActorsCallback = Future<List<Actor>> Function( String id );

/// movieId: Actores[]
/// '12345': <Actor>[],
/// '67890': <Actor>[],
/// '98765': <Actor>[],


class MovieActorsNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetMovieActorsCallback getMovieActors;

  MovieActorsNotifier({
    required this.getMovieActors,
  }): super({});

  Future<void> loadMovieActors( String movieId ) async {
    if( state[movieId] != null ) return;
    // print('obteniendo detalles de pelicula');
    final List<Actor> actors = await getMovieActors(movieId);

    state = {...state, movieId: actors};
  }
}