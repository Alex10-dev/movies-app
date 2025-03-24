import 'package:flutter/material.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/presentation/widgets/movies/movie_actor_card.dart';

class ActorsHorizontalList extends StatelessWidget {

  final List<Actor> actors;
  final double? horizontalPadding;

  const ActorsHorizontalList({super.key, required this.actors, this.horizontalPadding = 0});

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
          child: Text(
            'Actores',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.onPrimary),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0),
          height: 260,
          child: ListView.builder(
            itemCount: actors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {

              late double leftMargin = 6;
              late double rightMargin = 6;

              if( index == 0 ) {
                leftMargin = horizontalPadding!;
              } 
              if( index == actors.length - 1) {
                rightMargin = horizontalPadding!;
              } 

              return MovieActorCard( 
                imageUrl: actors[index].profilePath,
                margin: EdgeInsetsDirectional.only(start: leftMargin, end: rightMargin),
                width: 140,
                actorName: actors[index].name,
                character: actors[index].character,
              );
            },
          ),
        ),
      ],
    );
  }
}
