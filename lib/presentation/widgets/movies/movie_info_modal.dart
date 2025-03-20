import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/actors/movie_actors_provider.dart';
import 'package:movies/presentation/providers/movies/movie_detail_provider.dart';
import 'package:movies/presentation/providers/movies/related_movies_provider.dart';
import 'package:movies/presentation/widgets/movies/movie_info.dart';
import 'package:movies/presentation/widgets/movies/movies_grid.dart';

class MovieInfoModal extends ConsumerStatefulWidget {

  final String movieId;

  const MovieInfoModal({
    super.key,
    required this.movieId,
  });

  @override
  MovieInfoModalState createState() => MovieInfoModalState();
}

class MovieInfoModalState extends ConsumerState<MovieInfoModal> {

  @override
  void initState() {
    super.initState();

    ref.read( movieInfoProvider.notifier ).loadMovie( widget.movieId );
    ref.read( relatedMoviesProvider.notifier ).loadNextPage( widget.movieId );
    ref.read( movieActorsProvider.notifier ).loadMovieActors( widget.movieId );
  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch( movieInfoProvider )[widget.movieId];
    final List<Actor>? actors = ref.watch( movieActorsProvider )[widget.movieId];
    final List<Movie>? relatedMovies = ref.watch( relatedMoviesProvider )[widget.movieId];

    if( movie == null ) {
      return const Center(child: CircularProgressIndicator(),);
    }

    return Stack(
      children: <Widget>[

        Column(
          children: <Widget>[

            Container(
              color: Colors.amber,
              height: 320,
              width: double.infinity,
              child: Image.network(
                movie.backdropLink,
                fit: BoxFit.cover,
              ),
            ),

            _MovieTabsContainer(
              movie: movie,
              actors: actors ?? [],
              relatedMovies: relatedMovies ?? [],
            ),

          ],
        )

      ],
    );
  }
}

class _MovieTabsContainer extends StatelessWidget {

  final Movie movie;
  final List<Actor> actors;
  final List<Movie> relatedMovies;

  const _MovieTabsContainer({
    required this.movie, 
    required this.actors, 
    required this.relatedMovies,
  });

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        color: colors.primary,
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Column(
            children: <Widget>[
          
              TabBar(
                indicatorColor: colors.surface,
                labelColor: colors.surface,
                unselectedLabelColor: colors.outlineVariant,
                dividerColor: Colors.transparent,
                dividerHeight: 10.4,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                textScaler: const TextScaler.linear(1.2),
                tabs: const <Tab>[
                  Tab(text: 'Información'),
                  Tab(text: 'Sugerencias'),
                  Tab(text: 'Entradas'),
                ],
              ),
          
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: MovieInfo( 
                        movie: movie,
                        actors: actors,
                      ),
                    ),
                    MoviesGrid(movies: relatedMovies),
                    const Center(child: Text('Information 2')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

