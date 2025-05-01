import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/presentation/screens/movies/movie_info_screen.dart';

void showMovieModal(String movieId, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context, 
    builder: (BuildContext context) {
      return MovieInfoScreen(movieId: movieId);
    }
  ).then((_) {
    if( context.mounted ) {
      GoRouter.of(context).go('/');
    }
  });
}