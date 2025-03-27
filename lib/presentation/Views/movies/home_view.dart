import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/current_movie_on_carousel_provider.dart';
import 'package:movies/presentation/providers/movies/initial_loading_provider.dart';
import 'package:movies/presentation/providers/movies/movies_providers.dart';
import 'package:movies/presentation/widgets/movies/main_posters_carousel.dart';
import 'package:movies/presentation/widgets/movies/movies_cards_list.dart';
import 'package:movies/presentation/widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {

  final String? movieId;

  const HomeView({super.key, this.movieId});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final isLoadingInfo = ref.watch( initialLoadingProvider );
    if( isLoadingInfo ) return const FullScreenLoader();

    final List<Movie> nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final List<Movie> popularMovies = ref.watch( popularMoviesProvider );
    final List<Movie> upcomingMovies = ref.watch( upcomingMoviesProvider );
    final int carouselIndex = ref.watch( currentMovieOnCarouselProvider );
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[

            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.65,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Información', style: TextStyle(color: Colors.white),),
                background: MainPostersCarousel(
                  nowPlayingMovies: nowPlayingMovies,
                  index: carouselIndex,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: MoviesCardsList(
                  listTitle: 'Now Playing',
                  colors: colors, 
                  movies: nowPlayingMovies,
                  horizontalPadding: 10,
                  loadMoreMovies: () {
                    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: MoviesCardsList(
                  listTitle: 'Upcoming',
                  colors: colors, 
                  movies: upcomingMovies,
                  horizontalPadding: 10,
                  loadMoreMovies: () {
                    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: MoviesCardsList(
                  listTitle: 'Most Popular',
                  colors: colors, 
                  movies: popularMovies,
                  horizontalPadding: 10,
                  loadMoreMovies: () {
                    ref.read( popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),

          ],
        ),

        
      ],
    );
  }
}