import 'package:flutter/material.dart';
import 'package:movies/presentation/widgets/movies/movie_actor_card.dart';

class ActorsHorizontalList extends StatelessWidget {
  const ActorsHorizontalList({super.key});

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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: const MovieActorCard()
              ),
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: const MovieActorCard()
              ),
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: const MovieActorCard()
              ),
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: const MovieActorCard()
              ),
              Container(
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: const MovieActorCard()
              ),
            ],
          ),
        ),
      ],
    );
  }
}
