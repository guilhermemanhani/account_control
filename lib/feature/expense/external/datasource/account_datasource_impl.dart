import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../external/mappers/mappers.dart';
import '../../infra/datasource/datasource.dart';

class AccountDatasourceImpl implements AccountDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  AccountDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<AccountEntity>> getAccount() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select C.*, B.instituicao from conta C
      inner join BANCO B on B.id = C.idbanco
    ''');
    return result.map((e) => AccountEntityMapper.fromJson(e)).toList();
  }
}