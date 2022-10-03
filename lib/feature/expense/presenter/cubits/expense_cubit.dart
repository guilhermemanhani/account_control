import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/presenter/cubits/expense_state.dart';
import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:bloc/bloc.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetAccountInfoUsecase _usecase;

  ExpenseCubit({
    required GetAccountInfoUsecase usecase,
  })  : _usecase = usecase,
        super(
          ExpenseInitialState(),
        );
  Future<void> loadAccounts() async {
    emit(const ExpenseLoadingState());
    try {
      final List<AccountEntity> result = [];
      // await getMoviesUsecase.call();
      emit(ExpenseAccountLoadedState(expenseAccount: result));
    } catch (error) {
      emit(ExpenseErrorState(errorMessage: error.toString()));
    }
  }
}
