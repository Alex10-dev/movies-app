import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/domain/entities/movie.dart';

class MovieSearchItem extends StatelessWidget {
  const MovieSearchItem({
    super.key,
    required this.searchMovie,
  });

  final Movie searchMovie;

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 90,
      child: InkWell(
        onTap: () {
          // context.push('/movie/${widget.movies[index].id}');
          context.push('/movie/${searchMovie.id}');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
                ),
                height: double.infinity,
                width: 150,
                child: Image.network(
                  searchMovie.backdropLink,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchMovie.title, 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16, 
                        color: colors.onPrimaryContainer, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 4,),
                    Text(
                      searchMovie.releaseDate.toString().split(' ')[0],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.outline
                      ),
                    )
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