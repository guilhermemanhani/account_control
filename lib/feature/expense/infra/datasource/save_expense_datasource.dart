import '../../domain/entities/entities.dart';

abstract class SaveExpenseDatasource {
  Future<bool> saveExpense(
      {required ExpenseEntity expense, required double balanceAtt});
}
