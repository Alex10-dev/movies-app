import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/movies/current_movie_on_carousel_provider.dart';

class Carousel extends ConsumerStatefulWidget {

  final List<Movie> movies; 

  const Carousel({
    super.key, 
    required this.movies,
  });

  @override
  CarouselState createState() => CarouselState();
}

class CarouselState extends ConsumerState<Carousel> {

  final PageController _pageController = PageController(
    viewportFraction: 0.75,
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.movies.length,
      onPageChanged: (value) {
        ref.read( currentMovieOnCarouselProvider.notifier ).updateCurrentMovie(value);
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double scale = 1.0;
            if( _pageController.position.haveDimensions ){
              double page = _pageController.page ?? 0;
              scale = (1- ((page - index).abs() * 0.4)).clamp(0.65, 1);
            }
            return Center(
              child: SizedBox(
                height: scale * 200,
                child: child
              ),
            );
          },
          child: _ImageItem(
            backgorundColor: Colors.white,
            image: widget.movies.isEmpty 
              ? 'https://picsum.photos/250?image=9'
              : widget.movies[index].backdropLink
          ),
        );
      },
      physics: const BouncingScrollPhysics(),
    );
  }
}

class _ImageItem extends StatelessWidget {

  final Color backgorundColor;
  final String image;

  const _ImageItem({
    required this.backgorundColor,
    required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: backgorundColor,
        borderRadius: BorderRadius.circular(14)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: double.infinity,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}