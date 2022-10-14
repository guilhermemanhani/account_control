import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class SaveExpenseUsecase {
  Future<bool> call({required ExpenseEntity expense});
}

class SaveExpenseUsecaseImpl implements SaveExpenseUsecase {
  final SaveExpenseRepository _expenseRepository;

  SaveExpenseUsecaseImpl({
    required SaveExpenseRepository expenseRepository,
  }) : _expenseRepository = expenseRepository;

  @override
  Future<bool> call({required ExpenseEntity expense}) async {
    return await _expenseRepository.saveExpense(expense: expense);
  }
}
