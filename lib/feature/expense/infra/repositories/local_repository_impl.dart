import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDatasource _localDatasource;

  LocalRepositoryImpl({
    required LocalDatasource localDatasource,
  }) : _localDatasource = localDatasource;

  @override
  Future<List<LocalEntity>> getLocal() async {
    try {
      return await _localDatasource.getLocal();
    } catch (e) {
      throw Exception(e);
    }
  }
}
