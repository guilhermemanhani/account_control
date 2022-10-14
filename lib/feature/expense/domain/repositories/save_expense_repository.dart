import '../../domain/entities/entities.dart';

abstract class SaveExpenseRepository {
  Future<bool> saveExpense({required ExpenseEntity expense});
}
