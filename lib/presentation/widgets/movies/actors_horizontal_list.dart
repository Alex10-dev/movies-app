import 'package:flutter/material.dart';
import 'package:movies/domain/entities/actor.dart';
import 'package:movies/presentation/widgets/movies/movie_actor_card.dart';

class ActorsHorizontalList extends StatelessWidget {

  final List<Actor> actors;

  const ActorsHorizontalList({super.key, required this.actors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 12),
          child: Text(
            'Actores',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 0),
          height: 160,
          child: ListView.builder(
            itemCount: actors.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 6),
                child: MovieActorCard( imageUrl: actors[index].profilePath )
              );
            },
          ),
        ),
      ],
    );
  }
}
