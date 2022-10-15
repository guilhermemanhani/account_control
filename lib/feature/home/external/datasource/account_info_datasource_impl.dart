import 'package:account_control/core/database/sqlite_connection_factory.dart';
import 'package:account_control/feature/home/domain/entities/account_info_entity.dart';
import 'package:account_control/feature/home/external/mappers/account_info_entity_mapper.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';

class AccountInfoDatasourceImpl implements AccountInfoDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  AccountInfoDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;
  @override
  Future<List<AccountInfoEntity>> getAccountInfo() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select C.*, B.instituicao from conta C
      inner join BANCO B on B.id = C.idbanco
    ''');
    return result.map((e) => AccountInfoEntityMapper.fromJson(e)).toList();
  }
}
