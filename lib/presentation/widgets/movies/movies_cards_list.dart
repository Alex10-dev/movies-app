
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movies/movie_card.dart';
import 'package:movies/presentation/widgets/movies/movie_info_modal.dart';

class MoviesCardsList extends StatefulWidget {

  final ColorScheme colors;
  final List<Movie> movies;
  final String listTitle;
  final double? height;
  final double? horizontalPadding;
  final VoidCallback? loadMoreMovies;

  const MoviesCardsList({
    super.key,
    required this.colors,
    required this.movies, 
    required this.listTitle, 
    this.height = 320,
    this.horizontalPadding = 10, 
    this.loadMoreMovies,
  });

  @override
  State<MoviesCardsList> createState() => _MoviesCardsListState();
}

class _MoviesCardsListState extends State<MoviesCardsList> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener((){
      if( widget.loadMoreMovies == null ) return;

      if( (scrollController.position.pixels + 50) >= scrollController.position.maxScrollExtent ){
        // print('Load more movies');
        widget.loadMoreMovies!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding!),
            height: 40,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              overflow: TextOverflow.ellipsis,
              widget.listTitle,
              style: TextStyle(
                color: widget.colors.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
    
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {
                late double leftMargin = 6;
                late double rightMargin = 6;

                if( index == 0 ) {
                  leftMargin = widget.horizontalPadding!;
                } 
                if( index == widget.movies.length - 1) {
                  rightMargin = widget.horizontalPadding!;
                } 

                return MovieInfoModal(
                  movie: widget.movies[index],
                  child: MovieCard(
                    movie: widget.movies[index],
                    leftMargin: leftMargin,
                    rightMargin: rightMargin,
                  ),
                );
              },
            ),
          ),
    
        ],
      ),
    );
  }
}