import 'package:bloc/bloc.dart';

import '../../domain/usecases/usecases.dart';
import 'cubits.dart';

class HomeAppCubit extends Cubit<HomeState> {
  final GetAccountInfoUsecase _usecase;
  final FindByPeriodUsecase _findByPeriodUsecase;
  final GetExpenseByLocalUsecase _getExpenseByLocalUsecase;

  HomeAppCubit({
    required GetAccountInfoUsecase usecase,
    required FindByPeriodUsecase findByPeriodUsecase,
    required GetExpenseByLocalUsecase getExpenseByLocalUsecase,
  })  : _usecase = usecase,
        _findByPeriodUsecase = findByPeriodUsecase,
        _getExpenseByLocalUsecase = getExpenseByLocalUsecase,
        super(
          HomeInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const HomeLoadingState());
    try {
      final result = await _usecase.call();
      final budget = await _findByPeriodUsecase.call();
      final expenseByLocalExit =
          await _getExpenseByLocalUsecase.call(entryExit: 0);
      final expenseByLocalEntry =
          await _getExpenseByLocalUsecase.call(entryExit: 1);
      // getExpenseByLocalExit
      // getExpenseByLocalEntry
      emit(HomeLoadedState(
        accountsInfosEntity: result,
        expenseByLocalExitEntity: expenseByLocalExit,
        expenseByLocalEntryEntity: expenseByLocalEntry,
        budgetEntity: budget,
      ));
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
