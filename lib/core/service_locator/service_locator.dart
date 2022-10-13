import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';
import 'package:account_control/feature/home/domain/usecases/get_account_info_usecase.dart';
import 'package:account_control/feature/home/external/datasource/account_info_datasource_impl.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';
import 'package:account_control/feature/home/infra/repositories/account_info_repository_impl.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../core/database/database.dart';
import '../../feature/account/account.dart';
import '../../feature/expense/domain/repositories/repositories.dart';
import '../../feature/expense/domain/usecases/usecases.dart';
import '../../feature/expense/external/datasource/datasource.dart';
import '../../feature/expense/infra/datasource/datasource.dart';
import '../../feature/expense/infra/repositories/repositories.dart';
import '../../feature/expense/presenter/cubits/cubits.dart';

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
  // ? account get
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

  // ? local get

  getIt.registerSingleton<LocalDatasource>(
    LocalDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<LocalRepository>(
    LocalRepositoryImpl(
      localDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetLocalUsecase>(
    GetLocalUsecaseImpl(
      localRepository: getIt(),
    ),
  );

  // ? reason get

  getIt.registerSingleton<ReasonDatasource>(
    ReasonDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<ReasonRepository>(
    ReasonRepositoryImpl(
      reasonDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetReasonUsecase>(
    GetReasonUsecaseImpl(
      reasonRepository: getIt(),
    ),
  );

  // ? reason save

  getIt.registerSingleton<SaveReasonDatasource>(
    SaveReasonDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<SaveReasonRepository>(
    SaveReasonRepositoryImpl(
      saveReasonDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<SaveReasonUsecase>(
    SaveReasonUsecaseImpl(
      reasonRepository: getIt(),
    ),
  );

  // ? local save

  getIt.registerSingleton<SaveLocalDatasource>(
    SaveLocalDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<SaveLocalRepository>(
    SaveLocalRepositoryImpl(
      saveLocalDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<SaveLocalUsecase>(
    SaveLocalUsecaseImpl(
      localRepository: getIt(),
    ),
  );

  getIt.registerFactory<ExpenseCubit>(
    () => ExpenseCubit(
      accountUsecase: getIt(),
      localUsecase: getIt(),
      reasonUsecase: getIt(),
      saveLocalUsecase: getIt(),
      saveReasonUsecase: getIt(),
    ),
  );

  // ! save account

  getIt.registerSingleton<SaveAccountDatasource>(
    SaveAccountDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<SaveAccountRepository>(
    SaveAccountRepositoryImpl(
      saveAccountDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<SaveAccountUsecase>(
    SaveAccountUsecaseImpl(
      saveAccountRepository: getIt(),
    ),
  );

  // ? bank save

  getIt.registerSingleton<SaveBankDatasource>(
    SaveBankDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<SaveBankRepository>(
    SaveBankRepositoryImpl(
      saveBankDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<SaveBankUsecase>(
    SaveBankUsecaseImpl(
      bankRepository: getIt(),
    ),
  );

  // ? bank get

  getIt.registerSingleton<BankDatasource>(
    BankDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<BankRepository>(
    BankRepositoryImpl(
      bankDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetBankUsecase>(
    GetBankUsecaseImpl(
      bankRepository: getIt(),
    ),
  );

  getIt.registerFactory<SaveAccountCubit>(
    () => SaveAccountCubit(
      usecase: getIt(),
      getBankUsecase: getIt(),
      saveBankUsecase: getIt(),
    ),
  );
}
