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

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Sinopsis', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 12),
              Text(
                movie.overview,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              )
            ],
          )
        ),
        ActorsHorizontalList( actors: actors ),
      ],
    );
  }
}