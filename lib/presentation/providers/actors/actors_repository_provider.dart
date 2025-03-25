
//Este provider es de solo lectura
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/infrastructure/datasources/actor_themoviedb_datasource.dart';
import 'package:movies/infrastructure/repositories/actors_repository_imp.dart';

final actorsRepositoryProvider = Provider((ref) {

  return ActorsRepositoryImp(datasource: ActorThemoviedbDatasource());
});