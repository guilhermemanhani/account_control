import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';
import '../mappers/mappers.dart';

class ExpenseByLocalDatasourceImpl implements ExpenseByLocalDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  ExpenseByLocalDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<ExpenseByLocalEntity>> getExpenseByLocal(
      {required int entryExit}) async {
    final today = DateTime.now();
    final startFilter = DateTime(today.year, today.month - 1, 1, 0, 0, 0);
    final endFilter = DateTime(today.year, today.month + 1, 0, 0, 0, 0);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      SELECT COUNT(*) as contador, SUM(la.valor) as soma, la.tpagamento, lo.local as local FROM lancamento la
      inner join  local lo on la.localid = lo.id
      where datahora between ? and ?
      and la.tpagamento = ?
      group by lo.local
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
        entryExit,
      ],
    );
    return result.map((e) => ExpenseByLocalEntityMapper.fromJson(e)).toList();
  }
}
