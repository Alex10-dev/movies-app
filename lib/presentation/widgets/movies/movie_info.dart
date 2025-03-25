
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movies/actors_horizontal_list.dart';


class MovieInfo extends StatelessWidget {

  final Movie movie;
  final List<Actor> actors;

  const MovieInfo({
    super.key, 
    required this.movie, 
    required this.actors,
  });

  String _formatMovieDuration( int totalMinutes ){
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;
    return "${hours}h ${minutes}min";
  }

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      children: <Widget>[

        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text( 
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: colors.onPrimary),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_outlined, color: colors.outlineVariant, size: 16,),
                  Text(
                    movie.releaseDate.toString().split(' ')[0],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: colors.outlineVariant),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.timer_outlined, color: colors.outlineVariant, size: 16),
                  Text( 
                    _formatMovieDuration(movie.runtime!),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: colors.outlineVariant),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MovieBadge(
                    backgroundColor: colors.primaryContainer,
                    badgeValue: '${movie.voteAverage.toStringAsFixed(2)} / 10',
                    badgeTitle: 'Calificación',
                    badgeColor: Colors.yellow.shade700,
                    badgeIcon: Icon(Icons.star_outlined, color: colors.onPrimary, size: 40,),
                  ),
                  MovieBadge(
                    backgroundColor: colors.primaryContainer,
                    badgeValue: movie.popularity.toStringAsFixed(2),
                    badgeTitle: 'Popularidad',
                    badgeColor: Colors.green.shade600,
                    badgeIcon: Icon(Icons.volunteer_activism, color: colors.onPrimary, size: 40,),
                  ),
                  MovieBadge(
                    backgroundColor: colors.primaryContainer,
                    badgeValue: '${movie.voteCount}',
                    badgeTitle:  'Votos',
                    badgeColor: Colors.red,
                    badgeIcon: Icon(Icons.thumbs_up_down_sharp, color: colors.onPrimary, size: 40,),
                  ),
                ],
              ),

              const SizedBox(height: 18,),

              Text(
                'Sinopsis', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.onPrimary)
              ),
              const SizedBox(height: 12),
              Text(
                movie.overview,
                style: TextStyle(fontSize: 16, color: colors.surface),
              )
            ],
          )
        ),
        ActorsHorizontalList( actors: actors, horizontalPadding: 12 ),
        const SizedBox(height: 20,)
      ],
    );
  }
}

class MovieBadge extends StatelessWidget {
  const MovieBadge({
    super.key,
    required this.backgroundColor, 
    required this.badgeValue, 
    this.badgeTitle = '', 
    required this.badgeColor, 
    required this.badgeIcon,
  });

  final Color backgroundColor;
  final String badgeValue;
  final String? badgeTitle;
  final Color badgeColor;
  final Icon badgeIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        
        color: Colors.transparent
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  spreadRadius: 0
                )
              ],
              border: Border.all(
                width: 4, 
                color: Color.from(
                  alpha: 1, 
                  red: badgeColor.r - 0.4, 
                  green: badgeColor.g - 0.4, 
                  blue: badgeColor.b - 0.4,
                )
              ),
            ),
            child: badgeIcon
          ),
          const SizedBox(height: 8,),
          Text(
            badgeValue,
            style: const TextStyle( fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white ),
          ),
          Text(
            badgeTitle!,
            style: TextStyle( fontSize: 14, color: Colors.white.withAlpha(150)),
          ),
        ],
      ),
    );
  }
}