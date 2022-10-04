import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/domain/repositories/account_repository.dart';
import 'package:account_control/feature/expense/infra/datasource/account_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDatasource _accountDatasource;

  AccountRepositoryImpl({
    required AccountDatasource accountDatasource,
  }) : _accountDatasource = accountDatasource;
  @override
  Future<List<AccountEntity>> getAccount() async {
    try {
      return await _accountDatasource.getAccount();
    } catch (e) {
      throw Exception(e);
    }
  }
}
