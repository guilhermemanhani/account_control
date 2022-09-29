import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:account_control/feature/home/presenter/cubits/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAccountInfoUsecase getAccountInfoUsecase;
  HomeCubit({
    required GetAccountInfoUsecase getAccountUsecase,
  })  : getAccountInfoUsecase = getAccountUsecase,
        super(HomeInitialState());
  Future<void> loadAccounts() async {
    // emit(const MoviesLoadingState());
    // try {
    //   final result = await getMoviesUsecase.call();
    //   emit(MoviesLoadedState(movies: result));
    // } on MovieFailure catch (error) {
    //   emit(MoviesErrorState(errorMessage: error.errorMessage));
    // }
  }
}
