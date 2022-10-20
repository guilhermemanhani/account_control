import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_account_info_usecase.dart';
import '../../domain/usecases/get_expense_usecase.dart';
import 'cubits.dart';

class HomeAppCubit extends Cubit<HomeState> {
  final GetAccountInfoUsecase _usecase;
  final GetExpenseUsecase _expenseUsecase;

  HomeAppCubit(
      {required GetAccountInfoUsecase usecase,
      required GetExpenseUsecase expenseUsecase})
      : _usecase = usecase,
        _expenseUsecase = expenseUsecase,
        super(
          HomeInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const HomeLoadingState());
    try {
      final result = await _usecase.call();
      final expense = await _expenseUsecase.call();
      emit(HomeLoadedState(home: result));
    } catch (error) {
      emit(HomeErrorState(errorMessage: error.toString()));
    }
  }

  // Future<void> loadHome() async {
  //   emit(const HomeLoadingState());
  //   try {
  //     final result = await _usecase.call();
  //      loadAccounts();
  // findPeriod();
  // getExpenseByLocal();
  //     emit(HomeLoadedState(home: result));
  //   } catch (error) {
  //     emit(HomeErrorState(errorMessage: error.toString()));
  //   }
  // }

}
