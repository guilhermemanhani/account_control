import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

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
