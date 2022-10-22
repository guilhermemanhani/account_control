import '../../domain/entities/entities.dart';

abstract class ExpenseByAccountperiodDatasource {
  Future<List<ExpenseEntity>> getExpensesByAccountPeriod({
    required int idAccount,
    required DateTime start,
    required DateTime end,
  });
}
