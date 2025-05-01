
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/repositories/local_storage_repository.dart';
import 'package:movies/presentation/providers/storage/local_storage.dart';

final favoritesMoviesProvider = StateNotifierProvider<FavoritesMoviesNotifier, Map<int, Movie>>((ref) {

  final localStorageRepository= ref.watch( localStorageRepositoryProvider );
  return FavoritesMoviesNotifier(localStorageRepository: localStorageRepository);

});

class FavoritesMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoritesMoviesNotifier({
    required this.localStorageRepository,
  }): super({});

  Future<List<Movie>> loadNextPage() async{

    final movies = await localStorageRepository.executeLoadFavoriteMovies(
      offset: page * 10,
      limit: 20
    );
    page++;

    final tempMap = <int, Movie>{};
    for( final movie in movies ) {
      tempMap[movie.id] = movie;
    }

    state = { ...state, ...tempMap };
    
    return movies;
  }

  Future<void> toggleFavorite( Movie movie ) async{

    await localStorageRepository.executeToggleFavorite(movie);
    final bool isMovieInFavorites =  state[movie.id] != null;

    if( isMovieInFavorites ) {
      state.remove(movie.id);
      state = { ...state };
    } else {
      state = { ...state, movie.id: movie };
    }

  }

}