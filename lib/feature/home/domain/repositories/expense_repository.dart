import '../entities/entities.dart';

abstract class ExpenseRepository {
  Future<BudgetEntity> getExpense();
}
