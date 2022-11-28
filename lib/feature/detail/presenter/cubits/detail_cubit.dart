import 'package:bloc/bloc.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../cubits/cubits.dart';

class DetailCubit extends Cubit<DetailState> {
  final GetExpenseByAccountperiodUsecase _getExpenseByAccountperiodUsecase;
  // final SaveBankUsecase _saveBankUsecase;
  // final GetBankUsecase _getBankUsecase;
  DetailCubit({
    required GetExpenseByAccountperiodUsecase getExpenseByAccountperiodUsecase,
  })  : _getExpenseByAccountperiodUsecase = getExpenseByAccountperiodUsecase,
        super(DetailStateInitialState());
  Future<void> getExpensesByAccountPeriod() async {
    emit(const DetailStateLoadingState());
    try {
      // ! start com menos um mes no start
      // ! metodo q pega o mes da tela
      final List<ExpenseEntity> expenses =
          await _getExpenseByAccountperiodUsecase(
        idAccount: 1,
        start: DateTime.now(),
        end: DateTime.now(),
      );
      emit(DetailStateLoadedState(expenses: expenses));
    } catch (e) {
      emit(DetailStateErrorState(errorMessage: e.toString()));
    }
  }
}
