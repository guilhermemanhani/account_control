import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../cubits/cubits.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetAccountUsecase _accountUsecase;
  final GetBankUsecase _bankUsecase;
  final GetReasonUsecase _reasonUsecase;
  final GetLocalUsecase _localUsecase;
  final SaveBankUsecase _saveBankUsecase;
  final SaveReasonUsecase _saveReasonUsecase;
  final SaveLocalUsecase _saveLocalUsecase;

  ExpenseCubit({
    required GetAccountUsecase accountUsecase,
    required GetBankUsecase bankUsecase,
    required GetReasonUsecase reasonUsecase,
    required GetLocalUsecase localUsecase,
    required SaveBankUsecase saveBankUsecase,
    required SaveLocalUsecase saveLocalUsecase,
    required SaveReasonUsecase saveReasonUsecase,
  })  : _accountUsecase = accountUsecase,
        _bankUsecase = bankUsecase,
        _reasonUsecase = reasonUsecase,
        _localUsecase = localUsecase,
        _saveBankUsecase = saveBankUsecase,
        _saveReasonUsecase = saveReasonUsecase,
        _saveLocalUsecase = saveLocalUsecase,
        super(ExpenseInitialState());

  Future<void> loadScreen() async {
    emit(const ExpenseLoadingState());
    try {
      final account = await _accountUsecase.call();
      final bank = await _bankUsecase.call();
      final reason = await _reasonUsecase.call();
      final local = await _localUsecase.call();
      emit(ExpenseScreenLoadedState(
        expenseReason: reason,
        expenseLocal: local,
        expenseAccount: account,
        expenseBank: bank,
      ));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> loadAccounts() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _accountUsecase.call();
      debugPrint(result.toString());
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
      emit(ExpenseLocalLoadedState(expenseLocal: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> loadReasons() async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _reasonUsecase.call();
      debugPrint(result.toString());
      emit(ExpenseReasonLoadedState(expenseReason: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> saveBank(BankEntity bank) async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _saveBankUsecase.call(bank: bank);
      debugPrint(result.toString());
      emit(SaveBankSuccessState(success: true));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> saveReason(ReasonEntity reason) async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _saveReasonUsecase.call(reason: reason);
      debugPrint(result.toString());
      emit(SaveReasonSuccessState(success: true));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> saveLocal(LocalEntity local) async {
    emit(const ExpenseLoadingState());
    try {
      final result = await _saveLocalUsecase.call(local: local);
      debugPrint(result.toString());
      emit(SaveLocalSuccessState(success: true));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }
}
