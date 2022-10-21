import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class FindByPeriodUsecase {
  Future<BudgetEntity> call();
}

class FindByPeriodUsecaseImpl implements FindByPeriodUsecase {
  final ExpenseRepository _expenseRepository;

  FindByPeriodUsecaseImpl({
    required ExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  @override
  Future<BudgetEntity> call() async {
    return await _expenseRepository.getExpense();
  }
}
