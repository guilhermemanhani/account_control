import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class GetExpenseUsecase {
  Future<List<ExpenseEntity>> call();
}

class GetExpenseUsecaseimpl implements GetExpenseUsecase {
  final ExpenseRepository _expenseRepository;

  GetExpenseUsecaseimpl({
    required ExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  @override
  Future<List<ExpenseEntity>> call() async {
    return await _expenseRepository.getExpense();
  }
}
