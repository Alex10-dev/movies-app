import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/video.dart';
import 'package:movies/presentation/providers/actors/movie_actors_provider.dart';
import 'package:movies/presentation/providers/movies/movie_detail_provider.dart';
import 'package:movies/presentation/providers/movies/movie_videos_provider.dart';
import 'package:movies/presentation/providers/movies/related_movies_provider.dart';
import 'package:movies/presentation/widgets/movies/movie_info.dart';
import 'package:movies/presentation/widgets/movies/movies_grid.dart';
import 'package:movies/presentation/widgets/shared/video_player.dart';

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
    ref.read( movieVideosProvider.notifier ).loadVideos( widget.movieId );
  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch( movieInfoProvider )[widget.movieId];
    final List<Actor>? actors = ref.watch( movieActorsProvider )[widget.movieId];
    final List<Movie>? relatedMovies = ref.watch( relatedMoviesProvider )[widget.movieId];

    final List<Video>? videos = ref.watch( movieVideosProvider )[widget.movieId];

    if( movie == null || videos == null) {
      return const Center(child: CircularProgressIndicator(),);
    }

    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const _MovieModalAppbar(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[

              videos.isNotEmpty
              ? VideoPlayerAsset(url: videos[0].url) 
              : _MoviePosterNoVideo( url: movie.backdropLink),
                      
              _MovieTabsContainer(
                movie: movie,
                actors: actors ?? [],
                relatedMovies: relatedMovies ?? [],
              ),
                      
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviePosterNoVideo extends StatelessWidget {

  final String url;

  const _MoviePosterNoVideo({ 
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.orange,
      height: 320,
      width: double.infinity,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      )
    );
  }
}

class _MovieModalAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _MovieModalAppbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: Navigator.of(context).widget.pages.length > 2
        ? IconButton.filled(
          onPressed: (){
            GoRouter.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back), color: Colors.white,
        )
        : null,
      actions: <Widget>[
        IconButton.filled(
          onPressed: (){
            GoRouter.of(context).goNamed('home-screen');
          }, 
          icon: const Icon(Icons.close_rounded), color: Colors.white,
        )
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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

    // final ColorScheme colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Column(
            children: <Widget>[
          
              const TabBar(
                // indicatorColor: colors.surface,
                // labelColor: colors.surface,
                // unselectedLabelColor: colors.outlineVariant,
                dividerColor: Colors.transparent,
                dividerHeight: 10.4,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorAnimation: TabIndicatorAnimation.elastic,
                textScaler: TextScaler.linear(1.2),
                tabs: <Tab>[
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

