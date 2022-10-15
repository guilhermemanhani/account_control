import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:account_control/feature/home/presenter/cubits/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeAppCubit extends Cubit<HomeState> {
  final GetAccountInfoUsecase _usecase;

  HomeAppCubit({required GetAccountInfoUsecase usecase})
      : _usecase = usecase,
        super(
          HomeInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const HomeLoadingState());
    try {
      final result = await _usecase.call();
      emit(HomeLoadedState(home: result));
    } catch (error) {
      emit(HomeErrorState(errorMessage: error.toString()));
    }
  }
}
