
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/infrastructure/datasources/isar_local_storage_datasource.dart';
import 'package:movies/infrastructure/repositories/local_storage_repository_imp.dart';

final localStorageRepositoryProvider = Provider((ref) {

  return LocalStorageRepositoryImp( datasource: IsarLocalStorageDatasource() );
});