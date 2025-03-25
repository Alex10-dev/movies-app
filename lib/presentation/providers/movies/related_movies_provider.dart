
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movies_repository_provider.dart';

final relatedMoviesProvider = StateNotifierProvider<RelatedMoviesNotifier, Map<String, List<Movie>> >((ref){

  final fetchMoreMovies = ref.watch( moviesRepositoryProvider ).executeGetRelatedMovies;

  return RelatedMoviesNotifier(
    getRelatedMovies: fetchMoreMovies
  );
});

typedef RelatedMoviesCallback = Future<List<Movie>> Function({ int page, String id });

class RelatedMoviesNotifier extends StateNotifier<Map<String, List<Movie>>> {

  int currentPage = 1;
  final RelatedMoviesCallback getRelatedMovies;

  RelatedMoviesNotifier({
    required this.getRelatedMovies
  }): super({});

  Future<void> loadNextPage( String movieId ) async{

    if( state[movieId] != null ) return;

    final List<Movie> movies = await getRelatedMovies(id: movieId, page: currentPage);

    state = {...state, movieId: movies};

    await Future.delayed(const Duration(milliseconds: 100));
  }
}