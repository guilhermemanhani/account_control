import 'package:account_control/feature/home/infra/datasource/datasource.dart';

import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../mappers/mappers.dart';

class ExpenseDatasourceImpl implements ExpenseDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  ExpenseDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<ExpenseEntity>> getExpense() async {
    final today = DateTime.now();
    final startFilter = DateTime(today.year, today.month - 1, 1, 0, 0, 0);
    final endFilter = DateTime(today.year, today.month + 1, 0, 0, 0, 0);

    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
      ''' 
      select E.*, L.local, B.instituicao from lancamento E   
      inner join LOCAL L on L.id = E.localid
      inner join CONTA C on C.id = E.idconta
      inner join BANCO B on B.id = C.idbanco
      where datahora between ? and ?
      ''',
      [
        startFilter.toIso8601String(),
        endFilter.toIso8601String(),
      ],
    );
    return result.map((e) => ExpenseEntityMapper.fromJson(e)).toList();
  }
}
