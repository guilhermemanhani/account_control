import 'package:account_control/core/database/sqlite_connection_factory.dart';
import 'package:account_control/feature/expense/domain/repositories/account_repository.dart';
import 'package:account_control/feature/expense/domain/usecases/get_account_usecase.dart';
import 'package:account_control/feature/expense/external/datasource/account_datasource_impl.dart';
import 'package:account_control/feature/expense/infra/datasource/account_datasource.dart';
import 'package:account_control/feature/expense/infra/repositories/account_info_repository_impl.dart';
import 'package:account_control/feature/expense/presenter/cubits/expense_cubit.dart';
import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';
import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:account_control/feature/home/external/datasource/account_info_datasource_impl.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';
import 'package:account_control/feature/home/infra/repositories/account_info_repository_impl.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  getIt.registerFactory<SqliteConnectionFactory>(
    () => SqliteConnectionFactory(),
  );
  //datasource
  getIt.registerSingleton<AccountInfoDatasource>(
    AccountInfoDatasourceImpl(
      sqliteConnectionFactory: getIt(),
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

  getIt.registerFactory<HomeAppCubit>(
    () => HomeAppCubit(
      usecase: getIt(),
    ),
  );

  // ! expense

  getIt.registerSingleton<AccountDatasource>(
    AccountDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<AccountRepository>(
    AccountRepositoryImpl(
      accountDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetAccountUsecase>(
    GetAccountUsecaseImpl(
      accountRepository: getIt(),
    ),
  );

  getIt.registerFactory<ExpenseCubit>(
    () => ExpenseCubit(
      usecase: getIt(),
    ),
  );
}
