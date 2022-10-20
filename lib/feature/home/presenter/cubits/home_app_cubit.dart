import 'package:bloc/bloc.dart';

import '../../domain/usecases/find_by_period_usecase.dart';
import '../../domain/usecases/get_account_info_usecase.dart';
import 'cubits.dart';

class HomeAppCubit extends Cubit<HomeState> {
  final GetAccountInfoUsecase _usecase;
  final FindByPeriodUsecase _findByPeriodUsecase;

  HomeAppCubit(
      {required GetAccountInfoUsecase usecase,
      required FindByPeriodUsecase findByPeriodUsecase})
      : _usecase = usecase,
        _findByPeriodUsecase = findByPeriodUsecase,
        super(
          HomeInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const HomeLoadingState());
    try {
      final result = await _usecase.call();
      final expense = await _findByPeriodUsecase.call();
      // getExpenseByLocalExit
      // getExpenseByLocalEntry
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
