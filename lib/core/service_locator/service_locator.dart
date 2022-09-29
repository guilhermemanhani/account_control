import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';
import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';
import 'package:account_control/feature/home/infra/repositories/account_info_repository_impl.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  //movies feature

  //datasource
  getIt.registerSingleton<AccountInfoDatasource>(
    MoviesDatasourceImpl(
      dio: getIt(),
    ),
  );

  getIt.registerSingleton<AccountInfoRepository>(
    AccountInfoRepositoryImpl(
      accountDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetAccountInfoUsecase>(
    GetAccountInfoUsecaseImpl(
      accountInfoRepositoryRepository: getIt(),
    ),
  );
  // getIt.registerFactory<MoviesCubit>(
  //   () => MoviesCubit(
  //     getMoviesUsecase: getIt(),
  //   ),
  // );

  getIt.registerFactory<HomeAppCubit>(
    () => HomeAppCubit(
      getAccountUsecase: getIt(),
    ),
  );
}
