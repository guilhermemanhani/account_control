import '../../domain/entities/entities.dart';

abstract class ExpenseByAccountperiodRepository {
  Future<List<ExpenseEntity>> getExpensesByAccountPeriod({
    required int idAccount,
    required DateTime start,
    required DateTime end,
  });
}
