
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:movies/presentation/widgets/movies/movie_search_item.dart';

class FavoritesView extends ConsumerStatefulWidget {

  const FavoritesView({super.key });

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  final ScrollController scrollController = ScrollController();

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadNextPage() async{
    if( isLoading || isLastPage ) return;

    isLoading = true;
    final movies = await ref.read( favoritesMoviesProvider.notifier ).loadNextPage();
    isLoading = false;

    if( movies.isEmpty ) {
      isLastPage = true;
    }
    
  }

  @override
  Widget build(BuildContext context) {

    // final ColorScheme colors = Theme.of(context).colorScheme;
    final List<Movie> favoritesMovies = ref.watch( favoritesMoviesProvider ).values.toList();

    return Scaffold(

      appBar: AppBar(
        title: Text('Favoritos'),
      ),

      body: Stack(
        children: <Widget>[
      
          Positioned.fill(
            child: FavMoviesList(
              favoritesMovies: favoritesMovies,
              loadNextPage: loadNextPage,
            ),
          ),


        ],
      ),
    );
  }
}

class FavMoviesList extends StatefulWidget {

  const FavMoviesList({
    super.key,
    required this.favoritesMovies, 
    this.loadNextPage,
  });

  final List<Movie> favoritesMovies;
  final VoidCallback? loadNextPage;

  @override
  State<FavMoviesList> createState() => _FavMoviesListState();
}

class _FavMoviesListState extends State<FavMoviesList> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {

      if( scrollController.position.pixels + 50 >= scrollController.position.maxScrollExtent ) {
        widget.loadNextPage!();
        // print(scrollController.position.pixels);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: widget.favoritesMovies.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: MovieSearchItem(
          searchMovie: widget.favoritesMovies[index],
          currentView: 'favorites',
        ),
      ),
    );
  }
}