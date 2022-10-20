import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';
import '../mappers/mappers.dart';

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
