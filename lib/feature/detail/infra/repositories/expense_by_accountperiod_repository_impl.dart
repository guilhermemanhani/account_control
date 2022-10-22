import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class ExpenseByAccountperiodRepositoryImpl
    implements ExpenseByAccountperiodRepository {
  final ExpenseByAccountperiodDatasource _datasource;
  ExpenseByAccountperiodRepositoryImpl({
    required ExpenseByAccountperiodDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<List<ExpenseEntity>> getExpensesByAccountPeriod(
      {required int idAccount,
      required DateTime start,
      required DateTime end}) async {
    try {
      return await _datasource.getExpensesByAccountPeriod(
        idAccount: idAccount,
        start: start,
        end: end,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
