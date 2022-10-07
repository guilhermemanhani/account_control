import 'package:account_control/feature/account/domain/failures/save_account_failure.dart';
import 'package:bloc/bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../cubits/cubits.dart';

class SaveAccountCubit extends Cubit<SaveAccountState> {
  final SaveAccountUsecase _usecase;
  SaveAccountCubit({required SaveAccountUsecase usecase})
      : _usecase = usecase,
        super(SaveAccountInitialState());
  Future<void> saveAccount(SaveAccountEntity saveRequest) async {
    emit(SaveAccountLoadingState());
    try {
      final user = await _usecase.call(saveAccountEntity: saveRequest);
      emit(SaveAccountSuccessState(success: user));
    } on SaveAccountFailure catch (error) {
      emit(SaveAccountErrorState(errorMessage: error.errorMessage));
    }
  }
}
