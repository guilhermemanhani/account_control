import '../../../../core/failures/failure.dart';

abstract class SaveAccountFailure extends Failure {
  SaveAccountFailure({
    String errorMessage = '',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class DataSourceSaveAccountFailure extends SaveAccountFailure {
  DataSourceSaveAccountFailure({
    required String errorMessage,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}

class UnknownSaveAccountFailure extends SaveAccountFailure {
  UnknownSaveAccountFailure({
    String errorMessage = 'Ocorreu um erro inesperado, tente novamente.',
    StackTrace? stackTrace,
    String? label,
  }) : super(
          errorMessage: errorMessage,
          stackTrace: stackTrace,
          label: label,
        );
}
