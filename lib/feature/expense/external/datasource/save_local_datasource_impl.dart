import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';

class SaveLocalDatasourceImpl implements SaveLocalDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  SaveLocalDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<bool> saveLocal({required LocalEntity local}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'local',
      {
        'id': null,
        'nome': local.local,
      },
    );
    return true;
  }
}
