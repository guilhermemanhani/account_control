import 'package:account_control/feature/expense/domain/usecases/get_account_usecase.dart';
import 'package:account_control/feature/expense/presenter/cubits/expense_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetAccountUsecase _usecase;

  ExpenseCubit({
    required GetAccountUsecase usecase,
  })  : _usecase = usecase,
        super(
          ExpenseInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _usecase.call();
      debugPrint(result.toString());
      // await getMoviesUsecase.call();
      emit(ExpenseAccountLoadedState(expenseAccount: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }
}
