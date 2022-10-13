import 'package:flutter/foundation.dart';

import '../../domain/entities/entities.dart';

abstract class SaveAccountState {
  const SaveAccountState();
}

class SaveAccountInitialState extends SaveAccountState {}

class SaveAccountLoadingState extends SaveAccountState {
  const SaveAccountLoadingState();
}

class SaveAccountSuccessState extends SaveAccountState {
  final bool success;

  SaveAccountSuccessState({required this.success});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveAccountSuccessState && other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}

class SaveBankSuccessState extends SaveAccountState {
  final bool success;

  SaveBankSuccessState({required this.success});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveBankSuccessState && other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}

class AccountBankLoadedState extends SaveAccountState {
  final List<BankEntity> accountBank;

  AccountBankLoadedState({required this.accountBank});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountBankLoadedState &&
        listEquals(other.accountBank, accountBank);
  }

  @override
  int get hashCode => accountBank.hashCode;
}

class SaveAccountErrorState extends SaveAccountState {
  final String errorMessage;

  SaveAccountErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaveAccountErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
