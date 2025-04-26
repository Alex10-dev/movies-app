import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/providers/storage/local_storage.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {

  final localStorageRepository = ref.watch( localStorageRepositoryProvider );
  return localStorageRepository.executeIsMovieFavorite(movieId);
});

final favoriteStateProvider = StateProvider.family<bool, int>((ref, movieId) => false);

class FavoriteButton extends ConsumerWidget {

  final Movie movie;

  const FavoriteButton({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // final isFavoriteFuture = ref.watch( isFavoriteProvider(movie.id) );
    final isFavoriteAsync = ref.watch(isFavoriteProvider(movie.id));
    final favoriteOverride = ref.watch(favoriteStateProvider(movie.id));


    return IconButton(
      iconSize: 40,
      onPressed: () async{

        // ref.watch( localStorageRepositoryProvider ).executeToggleFavorite(movie);
        
        //invalida el valor que contiene el provider y lo resetea a su valor de inicio
        //esto provoca que vuelva hacer la petición o validación ya que se trata de un Future
        //al invalidar un future su valor inicial es de no resuelto y eso hace que se
        //vuelva a ejecutar para resolverse
        // ref.invalidate(isFavoriteProvider(movie.id));

        final localStorage = ref.read(localStorageRepositoryProvider);

        await localStorage.executeToggleFavorite(movie);

        // Al cambiar, actualiza el StateProvider también
        ref.read(favoriteStateProvider(movie.id).notifier).state = !(favoriteOverride);

        // Invalida el FutureProvider para sincronizar realmente el estado
        ref.invalidate(isFavoriteProvider(movie.id));
      }, 
      icon: isFavoriteAsync.when(
        data: (isFavorite) {
          final override = favoriteOverride == true ? favoriteOverride : isFavorite;
          return override
              ? const Icon(Icons.star_outlined, color: Colors.amber)
              : const Icon(Icons.star_border_outlined);
        },
        error: (_, __) => throw UnimplementedError(), 
        loading: () => CircularProgressIndicator( strokeWidth: 2,),
      )
      
      //const Icon(Icons.star_border_outlined,)
    );
  }
}