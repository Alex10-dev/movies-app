
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movies_providers.dart';
import 'package:movies/presentation/widgets/movies/main_posters_carousel.dart';
import 'package:movies/presentation/widgets/movies/movies_cards_list.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      body: const _HomeView()
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final List<Movie> nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final ColorScheme colors = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: <Widget>[

        SliverAppBar(
          backgroundColor: Colors.transparent,
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 650,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Información', style: TextStyle(color: Colors.white),),
            background: MainPostersCarousel(nowPlayingMovies: nowPlayingMovies),
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
              horizontalPadding: 12,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: MoviesCardsList(
              listTitle: 'Upcoming',
              colors: colors, 
              movies: nowPlayingMovies,
              horizontalPadding: 12,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: MoviesCardsList(
              listTitle: 'Most Popular',
              colors: colors, 
              movies: nowPlayingMovies,
              horizontalPadding: 12,
            ),
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),

      ],
    );
  }
}