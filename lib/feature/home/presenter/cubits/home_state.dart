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
  final AccountsInfosEntity home;

  HomeLoadedState({required this.home});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeLoadedState && other.home == home;
  }

  @override
  int get hashCode => home.hashCode;
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
