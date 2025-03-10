
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movies_repository_provider.dart';

/// State Notifier Provider como lo indica su nombre
/// es un proveedor de información que hace la notificación
/// cuando cambia el estado de nuestra aplicación
/// indicamos en el tipado del provider primero
/// la clase que controlar el provider y despues el estado
/// que en este caso es un listado de movie
/// <MoviesNotifier, List<Movie>

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){

  final fetchMoreMovies = ref.watch( moviesRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){

  final fetchMoreMovies = ref.watch( moviesRepositoryProvider ).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref){

  final fetchMoreMovies = ref.watch( moviesRepositoryProvider ).executeGetUpcoming;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


/// creamos el tipo de funcion que queremos recibir en el provider
/// es decir, con esto indicamos el qe provider debe tener una future function
/// que regrese un listado de movies y que reciba un parametro int
/// Esto se hace asi porque esta funcion ya existe en el repositorio
/// y por tanto necesitamos acceder a esa funcion en lugar de crear otra.
/// entonces el notifier que es la clase que se encarga de modificar el estado
/// ya puede ejecutar esta función para traer la información sin que tengamos
/// que crearnos una nueva funcion en dicha clase.
typedef MovieCallback = Future<List<Movie>> Function({ int page });

/*State Notifier pide indicar que tipo de estado va a mantener dentro
en este caso le indicamos que debe mantener el estado de un listado 
de movies, basicamente statenotifier sirve para poder manipular el estado
y siempre que el estaod cambia notifica*/

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  Future<void> loadNextPage() async{

    if( isLoading ) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading = false;
  }

}