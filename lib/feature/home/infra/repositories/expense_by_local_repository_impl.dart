import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class ExpenseByLocalRepositoryImpl implements ExpenseByLocalRepository {
  final ExpenseByLocalDatasource _expenseDatasource;
  ExpenseByLocalRepositoryImpl({
    required ExpenseByLocalDatasource expenseDatasource,
  }) : _expenseDatasource = expenseDatasource;
  @override
  Future<Map<String, double>> getExpenseByLocal(
      {required int entryExit}) async {
    try {
      final listExpense =
          await _expenseDatasource.getExpenseByLocal(entryExit: entryExit);
      // result.map((key, value) => MapEntry(key ?? "", value));
      // listExpense.map((e) {
      //   return <String, double>{};
      // });
      Map<String, double> dataMapEntry = <String, double>{};
      for (var local in listExpense) {
        dataMapEntry[local.local] = local.soma;
      }
      return dataMapEntry;
    } catch (e) {
      throw Exception(e);
    }
  }
}
