import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';

class SaveAccountDatasourceImpl implements SaveAccountDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  SaveAccountDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<bool> saveAccount(
      {required SaveAccountEntity saveAccountEntity}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.insert(
      'conta',
      {
        'id': null,
        'conta': saveAccountEntity.conta,
        'saldo': saveAccountEntity.saldo,
        'idbanco': saveAccountEntity.idbanco,
      },
    );
    return result > 0;
  }
}
