import '../../domain/entities/entities.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {}

//getHome
class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeLoadedState extends HomeState {
  final AccountsInfosEntity accountsInfosEntity;
  final Map<String, double> expenseByLocalExitEntity;
  final Map<String, double> expenseByLocalEntryEntity;
  final BudgetEntity budgetEntity;

  HomeLoadedState({
    required this.accountsInfosEntity,
    required this.expenseByLocalExitEntity,
    required this.expenseByLocalEntryEntity,
    required this.budgetEntity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeLoadedState &&
        other is AccountsInfosEntity &&
        other.accountsInfosEntity == accountsInfosEntity &&
        other is Map<String, double> &&
        other.expenseByLocalExitEntity == expenseByLocalExitEntity &&
        other is Map<String, double> &&
        other.expenseByLocalEntryEntity == expenseByLocalEntryEntity &&
        other is BudgetEntity &&
        other.budgetEntity == budgetEntity;
  }

  @override
  int get hashCode {
    return accountsInfosEntity.hashCode ^
        expenseByLocalExitEntity.hashCode ^
        expenseByLocalEntryEntity.hashCode ^
        budgetEntity.hashCode;
  }
}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeErrorState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

//getMovieInfo
class MovieInfoLoadingState extends HomeState {}

class MovieInfoLoadedState extends HomeState {}

class MovieInfoErrorState extends HomeState {}
