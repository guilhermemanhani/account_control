import '../repositories/repositories.dart';

abstract class GetExpenseByLocalUsecase {
  Future<Map<String, double>> call({required int entryExit});
}

class GetExpenseByLocalUsecaseImpl implements GetExpenseByLocalUsecase {
  final ExpenseByLocalRepository _expenseRepository;

  GetExpenseByLocalUsecaseImpl(
      {required ExpenseByLocalRepository expenseRepository})
      : _expenseRepository = expenseRepository;

  @override
  Future<Map<String, double>> call({required int entryExit}) async {
    return await _expenseRepository.getExpenseByLocal(entryExit: entryExit);
  }
}
