import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../infra/datasource/datasource.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseDatasource _expenseDatasource;

  ExpenseRepositoryImpl({
    required ExpenseDatasource expenseDatasource,
  }) : _expenseDatasource = expenseDatasource;

  @override
  Future<List<ExpenseEntity>> getExpense() async {
    try {
      final listExpense = await _expenseDatasource.getExpense();
      return listExpense;
    } catch (e) {
      throw Exception(e);
    }
  }
}
