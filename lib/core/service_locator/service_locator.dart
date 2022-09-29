import 'package:account_control/feature/home/presenter/cubits/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getAccountUsecase: getIt(),
    ),
  );
}
