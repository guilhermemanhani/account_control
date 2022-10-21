import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../infra/datasource/datasource.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseDatasource _expenseDatasource;

  ExpenseRepositoryImpl({
    required ExpenseDatasource expenseDatasource,
  }) : _expenseDatasource = expenseDatasource;

  @override
  Future<BudgetEntity> getExpense() async {
    try {
      final listExpense = await _expenseDatasource.getExpense();
      double entry = 0;
      double exit = 0;
      for (var element in listExpense) {
        if (element.tpagamento == 1) {
          entry += element.valor;
        } else {
          exit += element.valor;
        }
      }
      final budget = BudgetEntity(
        entryD: entry,
        exitD: exit,
        entry: (entry / 100).toStringAsFixed(2).replaceAll('.', ','),
        exit: (exit / 100).toStringAsFixed(2).replaceAll('.', ','),
        budgetUse: ((exit / entry) * 100).toStringAsFixed(2),
        entryxsaida:
            ((entry - exit) / 100).toStringAsFixed(2).replaceAll('.', ','),
      );
      return budget;
    } catch (e) {
      throw Exception(e);
    }
  }
}
