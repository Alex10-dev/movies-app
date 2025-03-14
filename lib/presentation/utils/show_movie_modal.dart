import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/presentation/widgets/movies/movie_info_modal.dart';

void showMovieModal(String movieId, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context, 
    builder: (BuildContext context) {
      return MovieInfoModal(movieId: movieId);
    }
  ).then((_) {
    if( context.mounted ) {
      GoRouter.of(context).go('/');
    }
  });
}