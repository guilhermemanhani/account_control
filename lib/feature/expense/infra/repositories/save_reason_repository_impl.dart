import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class SaveReasonRepositoryImpl implements SaveReasonRepository {
  final SaveReasonDatasource _saveReasonDatasource;

  SaveReasonRepositoryImpl({
    required SaveReasonDatasource saveReasonDatasource,
  }) : _saveReasonDatasource = saveReasonDatasource;

  @override
  Future<bool> saveReason({required ReasonEntity reason}) async {
    try {
      return await _saveReasonDatasource.saveReason(reason: reason);
      // } on SaveLocalFailure {
      //   rethrow;
    } catch (error, stackTrace) {
      throw UnknownExpenseFailure(
          stackTrace: stackTrace,
          label: 'saveReasonRepositoryImpl-saveAccount');
    }
  }
}
