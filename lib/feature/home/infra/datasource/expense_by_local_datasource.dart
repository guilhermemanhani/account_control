import '../../domain/entities/entities.dart';

abstract class ExpenseByLocalDatasource {
  Future<List<ExpenseByLocalEntity>> getExpenseByLocal(
      {required int entryExit});
}
