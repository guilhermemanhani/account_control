import '../../../../core/database/database.dart';
import '../../../account/account.dart';

class BankDatasourceImpl implements BankDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  BankDatasourceImpl({required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<BankEntity>> getBank() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('''
      select * from banco
    ''');
    return result.map((e) => BankEntityMapper.fromJson(e)).toList();
  }
}
