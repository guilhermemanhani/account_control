import '../../../../core/database/database.dart';
import '../../domain/entities/entities.dart';
import '../../infra/datasource/datasource.dart';

class SaveExpenseDatasourceImpl implements SaveExpenseDatasource {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  SaveExpenseDatasourceImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<bool> saveExpense(
      {required ExpenseEntity expense, required double balanceAtt}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(
      'lancamento',
      {
        'idlancamento': null,
        'datahora': expense.datahora.toIso8601String(),
        'valor': expense.valor,
        'descricao': expense.descricao,
        'idconta': expense.idconta,
        'localid': expense.localid,
        'motivoid': expense.motivoid,
        'tpagamento': expense.tpagamento,
      },
    );

    await conn.rawUpdate(
      'update conta set saldo = ? where id = ?',
      [balanceAtt, expense.idconta],
    );

    return true;
  }
}
