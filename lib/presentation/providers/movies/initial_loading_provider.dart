
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/presentation/providers/movies/movies_providers.dart';

//Este provider se encargara de indicar si los demas providers ya tienen información o no
final initialLoadingProvider = Provider<bool>((ref) {

  final bool step1 = ref.watch( nowPlayingMoviesProvider ).isEmpty;
  final bool step2 = ref.watch( popularMoviesProvider ).isEmpty;
  final bool step3 = ref.watch( upcomingMoviesProvider ).isEmpty;

  if( step1 || step2 || step3 ) return true;

  return false;

});