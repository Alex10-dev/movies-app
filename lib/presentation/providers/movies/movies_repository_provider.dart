
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:movies/infrastructure/repositories/movies_repository_imp.dart';

//Este provider es de solo lectura
final moviesRepositoryProvider = Provider((ref) {

  return MoviesRepositoryImp(datasource: ThemoviedbDatasource());
});