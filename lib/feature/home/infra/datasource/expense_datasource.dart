import '../../domain/entities/entities.dart';

abstract class ExpenseDatasource {
  Future<List<ExpenseEntity>> getExpense();
}
