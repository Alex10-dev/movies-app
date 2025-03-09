import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/shared/custom_carousel.dart';

class MainPostersCarousel extends StatelessWidget {
  const MainPostersCarousel({
    super.key,
    required this.nowPlayingMovies,
  });

  final List<Movie> nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Expanded(
              child: Image.network(
                nowPlayingMovies.isEmpty 
                  ? 'https://picsum.photos/250?image=9' 
                  : nowPlayingMovies[7].posterLink, 
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
    
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const <double>[ 0.2, 0.75 ],
              colors: <Color>[
                Colors.black.withAlpha(180),
                Colors.black.withAlpha(0)
              ],
            )
          ),
        ),
    
        Column(
          children: <Widget>[
            const Spacer(),
            SizedBox(
              height: 200,
              child: Carousel(movies: nowPlayingMovies,)
            )
          ],
        )
    
      ],
    );
  }
}