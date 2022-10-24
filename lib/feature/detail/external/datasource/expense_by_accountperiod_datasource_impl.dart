import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';
import '../mappers/mappers.dart';

class ExpenseByAccountperiodDatasourceImpl
    implements ExpenseByAccountperiodDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  ExpenseByAccountperiodDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<ExpenseEntity>> getExpensesByAccountPeriod({
    required int idAccount,
    required DateTime start,
    required DateTime end,
  }) async {
    final startFilter =
        DateTime(start.year, start.month - 1, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      select E.*, L.local, B.instituicao from lancamento E   
      inner join LOCAL L on L.id = E.localid
      inner join CONTA C on C.id = E.idconta
      inner join BANCO B on B.id = C.idbanco
      where e.idconta = ?
      and datahora between ? and ?
      order by e.datahora
      ''',
      [
        idAccount,
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );

    return result.map((e) => ExpenseEntityMapper.fromJson(e)).toList();
  }
}
