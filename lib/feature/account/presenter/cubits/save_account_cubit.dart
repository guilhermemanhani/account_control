import 'package:account_control/feature/account/domain/failures/save_account_failure.dart';
import 'package:bloc/bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../cubits/cubits.dart';

class SaveAccountCubit extends Cubit<SaveAccountState> {
  final SaveAccountUsecase _usecase;
  final SaveBankUsecase _saveBankUsecase;
  final GetBankUsecase _getBankUsecase;

  SaveAccountCubit({
    required SaveAccountUsecase usecase,
    required SaveBankUsecase saveBankUsecase,
    required GetBankUsecase getBankUsecase,
  })  : _usecase = usecase,
        _saveBankUsecase = saveBankUsecase,
        _getBankUsecase = getBankUsecase,
        super(SaveAccountInitialState());

  Future<void> saveAccount(SaveAccountEntity saveRequest) async {
    emit(const SaveAccountLoadingState());
    try {
      final user = await _usecase.call(saveAccountEntity: saveRequest);
      emit(SaveAccountSuccessState(success: user));
    } on SaveAccountFailure catch (error) {
      emit(SaveAccountErrorState(errorMessage: error.errorMessage));
    }
  }

  Future<void> loadBanks() async {
    emit(const SaveAccountLoadingState());
    try {
      final result = await _getBankUsecase.call();
      emit(AccountBankLoadedState(accountBank: result));
    } catch (error) {
      emit(SaveAccountErrorState(errorMessage: error.toString()));
    }
  }

  Future<void> saveBank(BankEntity bank) async {
    emit(const SaveAccountLoadingState());
    try {
      final result = await _saveBankUsecase.call(bank: bank);
      emit(SaveBankSuccessState(success: result));
      loadBanks();
    } catch (error) {
      emit(SaveAccountErrorState(errorMessage: error.toString()));
    }
  }
}
