import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {

  final Movie movie;
  final double? leftMargin;
  final double? rightMargin;

  const MovieCard({
    super.key,
    required this.movie,
    this.leftMargin = 5,
    this.rightMargin = 5,
  });

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(left: leftMargin!, right: rightMargin!),
      width: 160,
      height: 280,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              width: double.infinity,
              child: Image.network(
                movie.posterLink,
                fit: BoxFit.cover,
              ),
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            color: Colors.transparent,
            width: double.infinity,
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  movie.title,
                  style: TextStyle(
                    color: colors.onPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  "${movie.releaseDate.toString().split(' ')[0]} ${movie.isForAdult ? 'Para Adultos' : 'Todo Publico'}",
                  style: TextStyle(
                    color: colors.onPrimary.withAlpha(200),
                    fontSize: 12,
                    fontWeight: FontWeight.normal
                  ),
                ),


              ],
            ),
          )
        ],
      )
    );
  }
}