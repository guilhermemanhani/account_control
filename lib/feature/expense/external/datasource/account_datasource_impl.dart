import 'package:account_control/core/database/sqlite_connection_factory.dart';
import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/external/mappers/account_entity_mapper.dart';
import 'package:account_control/feature/expense/infra/datasource/account_datasource.dart';

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
