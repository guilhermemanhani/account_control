import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountDatasource _accountDatasource;

  AccountRepositoryImpl({
    required AccountDatasource accountDatasource,
  }) : _accountDatasource = accountDatasource;
  @override
  Future<List<AccountEntity>> getAccounts() async {
    try {
      return await _accountDatasource.getAccounts();
    } catch (e) {
      throw Exception(e);
    }
  }
}
