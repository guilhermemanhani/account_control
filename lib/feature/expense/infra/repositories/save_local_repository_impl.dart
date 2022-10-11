import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class SaveLocalRepositoryImpl implements SaveLocalRepository {
  final SaveLocalDatasource _saveLocalDatasource;

  SaveLocalRepositoryImpl({
    required SaveLocalDatasource saveLocalDatasource,
  }) : _saveLocalDatasource = saveLocalDatasource;

  @override
  Future<bool> saveLocal({required LocalEntity local}) async {
    try {
      return await _saveLocalDatasource.saveLocal(local: local);
      // } on SaveLocalFailure {
      //   rethrow;
    } catch (error, stackTrace) {
      throw UnknownExpenseFailure(
          stackTrace: stackTrace, label: 'saveLocalRepositoryImpl-saveAccount');
    }
  }
}
