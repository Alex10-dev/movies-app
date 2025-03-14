import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/movie_detail_provider.dart';
import 'package:movies/presentation/widgets/movies/movie_info.dart';

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
  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch( movieInfoProvider )[widget.movieId];

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

            _MovieTabsContainer(movie: movie),

          ],
        )

      ],
    );
  }
}

class _MovieTabsContainer extends StatelessWidget {

  final Movie movie;

  const _MovieTabsContainer({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            children: <Widget>[
          
              const TabBar(
                indicatorColor: Colors.black,
                tabs: <Tab>[
                  Tab(text: 'Información'),
                  Tab(text: 'Entradas'),
                ],
              ),
          
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: MovieInfo( movie: movie,),
                    ),
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