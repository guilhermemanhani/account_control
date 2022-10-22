import 'package:flutter/foundation.dart';

import '../../domain/entities/entities.dart';

abstract class DetailState {
  const DetailState();
}

class DetailStateInitialState extends DetailState {}

class DetailStateLoadingState extends DetailState {
  const DetailStateLoadingState();
}

class DetailStateLoadedState extends DetailState {
  final List<ExpenseEntity> expenses;

  DetailStateLoadedState({required this.expenses});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailStateLoadedState &&
        listEquals(other.expenses, expenses);
  }

  @override
  int get hashCode => expenses.hashCode;
}

class DetailStateErrorState extends DetailState {
  final String errorMessage;

  DetailStateErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailStateErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
