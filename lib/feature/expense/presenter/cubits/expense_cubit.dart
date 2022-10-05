import 'package:account_control/feature/expense/presenter/cubits/expense_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/usecases.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetAccountUsecase _accountUsecase;
  final GetBankUsecase _bankUsecase;
  final GetReasonUsecase _reasonUsecase;
  final GetLocalUsecase _localUsecase;

  ExpenseCubit({
    required GetAccountUsecase accountUsecase,
    required GetBankUsecase bankUsecase,
    required GetReasonUsecase reasonUsecase,
    required GetLocalUsecase localUsecase,
  })  : _accountUsecase = accountUsecase,
        _bankUsecase = bankUsecase,
        _reasonUsecase = reasonUsecase,
        _localUsecase = localUsecase,
        super(ExpenseInitialState());

  Future<void> loadAccounts() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _accountUsecase.call();
      debugPrint(result.toString());
      // await getMoviesUsecase.call();
      emit(ExpenseAccountLoadedState(expenseAccount: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> loadBanks() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _bankUsecase.call();
      debugPrint(result.toString());
      // await getMoviesUsecase.call();
      emit(ExpenseBankLoadedState(expenseBank: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> loadLocals() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _localUsecase.call();
      debugPrint(result.toString());
      // await getMoviesUsecase.call();
      emit(ExpenseLocalLoadedState(expenseLocal: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  // Future<void> loadReasons() async {
  //   emit(const ExpenseLoadingState());
  //   try {
  //     final result = await _reasonUsecase.call();
  //     debugPrint(result.toString());
  //     // await getMoviesUsecase.call();
  //     emit(ExpenseReasonLoadedState(expenseReason: result));
  //   } catch (error) {
  //     emit(ExpenseErrorState(errorMessage: error.toString()));
  //   }
  // }
}
