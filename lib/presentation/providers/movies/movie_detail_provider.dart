

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movies_repository_provider.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {

  final movieRepository = ref.watch( moviesRepositoryProvider );

  return MovieMapNotifier(getMovie: movieRepository.executeGetMovieById );
});

typedef GetMovieCallback = Future<Movie> Function({ required String id });

/// state
/// '12345': Movie(),
/// '67890': Movie(),
/// '98765': Movie(),


class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }): super({});

  Future<void> loadMovie( String movieId ) async {
    if( state[movieId] != null ) return;
    // print('obteniendo detalles de pelicula');
    final movie = await getMovie(id: movieId);

    state = {...state, movieId: movie};
  }
}