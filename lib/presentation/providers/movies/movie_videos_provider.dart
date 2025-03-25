
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/video.dart';
import 'package:movies/presentation/providers/movies/movies_repository_provider.dart';

final movieVideosProvider = StateNotifierProvider<MovieVideosMapNotifier, Map<String, List<Video>>>((ref) {

  final movieRepository = ref.watch( moviesRepositoryProvider );

  return MovieVideosMapNotifier(
    getMovieVideos: movieRepository.executeGetMovieVideos
  );

});


typedef GetVideosCallback = Future<List<Video>> Function({ required String id });


class MovieVideosMapNotifier extends StateNotifier<Map<String, List<Video> >> {

  final GetVideosCallback getMovieVideos;

  MovieVideosMapNotifier({
    required this.getMovieVideos
  }): super({});

  Future<void> loadVideos( String movieId ) async{

    if( state[movieId] != null ) return;

    final List<Video> videos = await getMovieVideos(id: movieId);
    // if( videos.isEmpty ) state = {...state, movieId: []};

    state = {...state, movieId: videos};

    await Future.delayed(const Duration(milliseconds: 100));
  }

}