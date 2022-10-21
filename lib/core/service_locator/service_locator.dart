import 'package:get_it/get_it.dart';

import '../../core/database/database.dart';
import '../../feature/account/account.dart';
import '../../feature/expense/domain/repositories/repositories.dart';
import '../../feature/expense/domain/usecases/usecases.dart';
import '../../feature/expense/external/datasource/datasource.dart';
import '../../feature/expense/infra/datasource/datasource.dart';
import '../../feature/expense/infra/repositories/repositories.dart';
import '../../feature/expense/presenter/cubits/cubits.dart';
import '../../feature/home/domain/repositories/repositories.dart';
import '../../feature/home/domain/usecases/usecases.dart';
import '../../feature/home/external/datasource/datasource.dart';
import '../../feature/home/infra/datasource/datasource.dart';
import '../../feature/home/infra/repositories/repositories.dart';
import '../../feature/home/presenter/cubits/cubits.dart';

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

  getIt.registerSingleton<ExpenseDatasource>(
    ExpenseDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<ExpenseRepository>(
    ExpenseRepositoryImpl(
      expenseDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<FindByPeriodUsecase>(
    FindByPeriodUsecaseImpl(
      expenseRepository: getIt(),
    ),
  );

  getIt.registerSingleton<ExpenseByLocalDatasource>(
    ExpenseByLocalDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<ExpenseByLocalRepository>(
    ExpenseByLocalRepositoryImpl(
      expenseDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<GetExpenseByLocalUsecase>(
    GetExpenseByLocalUsecaseImpl(
      expenseRepository: getIt(),
    ),
  );

  getIt.registerFactory<HomeAppCubit>(
    () => HomeAppCubit(
      usecase: getIt(),
      findByPeriodUsecase: getIt(),
      getExpenseByLocalUsecase: getIt(),
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

  // ? account save

  // getIt.registerSingleton<AccountDatasource>(
  //   AccountDatasourceImpl(
  //     sqliteConnectionFactory: getIt(),
  //   ),
  // );
  // AccountDatasource
  // AccountDatasource

  // ? expense save

  getIt.registerSingleton<SaveExpenseDatasource>(
    SaveExpenseDatasourceImpl(
      sqliteConnectionFactory: getIt(),
    ),
  );

  getIt.registerSingleton<SaveExpenseRepository>(
    SaveExpenseRepositoryImpl(
      saveExpenseDatasource: getIt(),
      accountDatasource: getIt(),
    ),
  );

  getIt.registerSingleton<SaveExpenseUsecase>(
    SaveExpenseUsecaseImpl(
      expenseRepository: getIt(),
    ),
  );

  getIt.registerFactory<ExpenseCubit>(
    () => ExpenseCubit(
      accountUsecase: getIt(),
      localUsecase: getIt(),
      reasonUsecase: getIt(),
      saveLocalUsecase: getIt(),
      saveReasonUsecase: getIt(),
      saveExpenseUsecase: getIt(),
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
