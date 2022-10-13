import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';

class SaveBankDatasourceImpl implements SaveBankDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  SaveBankDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<bool> saveBank({required BankEntity bank}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'banco',
      {
        'id': null,
        'instituicao': bank.instituicao,
      },
    );
    return true;
  }
}
