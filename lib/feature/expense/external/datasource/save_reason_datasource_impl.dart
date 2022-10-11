import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';

class SaveReasonDatasourceImpl implements SaveReasonDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  SaveReasonDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<bool> saveReason({required ReasonEntity reason}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'motivo',
      {
        'id': null,
        'motivo': reason.motivo,
      },
    );
    return true;
  }
}
