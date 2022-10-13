import 'package:flutter/foundation.dart';

import '../../domain/entities/entities.dart';

abstract class ExpenseState {
  const ExpenseState();
}

class ExpenseInitialState extends ExpenseState {}

//getExpense
class ExpenseLoadingState extends ExpenseState {
  const ExpenseLoadingState();
}

class ExpenseScreenLoadedState extends ExpenseState {
  final List<AccountEntity> expenseAccount;

  final List<ReasonEntity> expenseReason;
  final List<LocalEntity> expenseLocal;

  ExpenseScreenLoadedState(
      {required this.expenseAccount,
      required this.expenseReason,
      required this.expenseLocal});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseScreenLoadedState &&
        listEquals(other.expenseAccount, expenseAccount) &&
        listEquals(other.expenseReason, expenseReason) &&
        listEquals(other.expenseLocal, expenseLocal);
  }

  @override
  int get hashCode {
    return expenseAccount.hashCode ^
        expenseReason.hashCode ^
        expenseLocal.hashCode;
  }
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

class ExpenseReasonLoadedState extends ExpenseState {
  final List<ReasonEntity> expenseReason;

  ExpenseReasonLoadedState({required this.expenseReason});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseReasonLoadedState &&
        listEquals(other.expenseReason, expenseReason);
  }

  @override
  int get hashCode => expenseReason.hashCode;
}

class SaveReasonSuccessState extends ExpenseState {
  final bool success;

  SaveReasonSuccessState({required this.success});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveReasonSuccessState && other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}

class SaveLocalSuccessState extends ExpenseState {
  final bool success;

  SaveLocalSuccessState({required this.success});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveLocalSuccessState && other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
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
