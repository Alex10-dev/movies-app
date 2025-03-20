
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentMovieOnCarouselProvider = StateNotifierProvider<CurrentMovieOnCarouselNotifier, int>((ref){
  return CurrentMovieOnCarouselNotifier();
});

class CurrentMovieOnCarouselNotifier extends StateNotifier<int> {
  
  CurrentMovieOnCarouselNotifier(): super(0);

  void updateCurrentMovie( int index ) {
    if( state == index ) return;
    state = index;    
  }
}