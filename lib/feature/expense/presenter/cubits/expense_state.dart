import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/domain/entities/bank_entity.dart';
import 'package:account_control/feature/expense/domain/entities/local_entity.dart';
import 'package:account_control/feature/expense/domain/entities/reasons_entity.dart';
import 'package:flutter/foundation.dart';

abstract class ExpenseState {
  const ExpenseState();
}

class ExpenseInitialState extends ExpenseState {}

//getExpense
class ExpenseLoadingState extends ExpenseState {
  const ExpenseLoadingState();
}

class ExpenseAccountLoadedState extends ExpenseState {
  final List<AccountEntity> expenseAccount;

  ExpenseAccountLoadedState({required this.expenseAccount});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseAccountLoadedState &&
        listEquals(other.expenseAccount, expenseAccount);
  }

  @override
  int get hashCode => expenseAccount.hashCode;
}

class ExpenseBankLoadedState extends ExpenseState {
  final List<BankEntity> expenseBank;

  ExpenseBankLoadedState({required this.expenseBank});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseBankLoadedState &&
        listEquals(other.expenseBank, expenseBank);
  }

  @override
  int get hashCode => expenseBank.hashCode;
}

class ExpenseLocalLoadedState extends ExpenseState {
  final List<LocalEntity> expenseLocal;

  ExpenseLocalLoadedState({required this.expenseLocal});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseLocalLoadedState &&
        listEquals(other.expenseLocal, expenseLocal);
  }

  @override
  int get hashCode => expenseLocal.hashCode;
}

class ExpenseReasonsLoadedState extends ExpenseState {
  final List<ReasonsEntity> expenseReasons;

  ExpenseReasonsLoadedState({required this.expenseReasons});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseReasonsLoadedState &&
        listEquals(other.expenseReasons, expenseReasons);
  }

  @override
  int get hashCode => expenseReasons.hashCode;
}

class ExpenseEmptyState extends ExpenseState {}

class ExpenseErrorState extends ExpenseState {
  final String errorMessage;

  ExpenseErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

//getMovieInfo
class MovieInfoLoadingState extends ExpenseState {}

class MovieInfoLoadedState extends ExpenseState {}

class MovieInfoErrorState extends ExpenseState {}
