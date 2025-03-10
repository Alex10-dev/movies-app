
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movies/movie_card.dart';

class MoviesCardsList extends StatelessWidget {

  final ColorScheme colors;
  final List<Movie> movies;
  final String listTitle;
  final double? height;
  final double? horizontalPadding;

  const MoviesCardsList({
    super.key,
    required this.colors,
    required this.movies, 
    required this.listTitle, 
    this.height = 320,
    this.horizontalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding!),
            height: 40,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              overflow: TextOverflow.ellipsis,
              listTitle,
              style: TextStyle(
                color: colors.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
    
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieCard(
                  movie: movies[index],
                  leftMargin: horizontalPadding,
                );
              },
            ),
          ),
    
        ],
      ),
    );
  }
}