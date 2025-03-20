import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        mainAxisExtent: 200,
      ),
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      itemCount: movies.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black, 
                offset: Offset(2, 3),
                blurRadius: 5,
                spreadRadius: -2
              )
            ]
          ),
          child: Image.network(
            fit: BoxFit.cover,
            movies[index].posterLink == '' 
              ? 'https://picsum.photos/250?image=9' 
              : movies[index].posterLink
          )
        );
      },
    );
  }
}