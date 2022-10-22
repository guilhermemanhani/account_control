import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

abstract class GetExpenseByAccountperiodUsecase {
  Future<List<ExpenseEntity>> call({
    required int idAccount,
    required DateTime start,
    required DateTime end,
  });
}

class GetExpenseByAccountperiodUsecaseImpl
    implements GetExpenseByAccountperiodUsecase {
  final ExpenseByAccountperiodRepository _repository;

  GetExpenseByAccountperiodUsecaseImpl({
    required ExpenseByAccountperiodRepository repository,
  }) : _repository = repository;

  @override
  Future<List<ExpenseEntity>> call({
    required int idAccount,
    required DateTime start,
    required DateTime end,
  }) async {
    return await _repository.getExpensesByAccountPeriod(
      idAccount: idAccount,
      start: start,
      end: end,
    );
  }
}
