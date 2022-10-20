import '../entities/entities.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseEntity>> getExpense();
}
