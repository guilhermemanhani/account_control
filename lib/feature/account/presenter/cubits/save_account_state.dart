abstract class SaveAccountState {}

class SaveAccountInitialState extends SaveAccountState {}

class SaveAccountLoadingState extends SaveAccountState {}

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
