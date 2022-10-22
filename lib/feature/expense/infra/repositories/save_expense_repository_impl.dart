import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class SaveExpenseRepositoryImpl implements SaveExpenseRepository {
  final SaveExpenseDatasource _saveExpenseDatasource;
  final AccountDatasource _accountDatasource;
  SaveExpenseRepositoryImpl({
    required SaveExpenseDatasource saveExpenseDatasource,
    required AccountDatasource accountDatasource,
  })  : _saveExpenseDatasource = saveExpenseDatasource,
        _accountDatasource = accountDatasource;
  @override
  Future<bool> saveExpense({required ExpenseEntity expense}) async {
    try {
      double balanceAtt;
      AccountEntity account =
          await _accountDatasource.getAccount(id: expense.idconta);

      ExpenseEntity expenseEntity = ExpenseEntity(
        datahora: expense.datahora,
        idlancamento: expense.idlancamento,
        instituicao: expense.instituicao,
        local: expense.local,
        idconta: expense.idconta,
        valor: expense.valor * 100,
        descricao: expense.descricao,
        localid: expense.localid,
        motivo: expense.motivo,
        motivoid: expense.motivoid,
        tpagamento: expense.tpagamento,
      );
      if (expense.tpagamento == 0) {
        balanceAtt = account.saldo - expense.valor * 100;
      } else {
        balanceAtt = account.saldo + expense.valor * 100;
      }
      return await _saveExpenseDatasource.saveExpense(
          expense: expenseEntity, balanceAtt: balanceAtt);
    } catch (e) {
      throw Exception(e);
    }
  }
}
