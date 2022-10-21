import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasource/datasource.dart';

class AccountInfoRepositoryImpl implements AccountInfoRepository {
  final AccountInfoDatasource _accountDatasource;

  AccountInfoRepositoryImpl({
    required AccountInfoDatasource accountDatasource,
  }) : _accountDatasource = accountDatasource;
  @override
  Future<AccountsInfosEntity> getAccountInfo() async {
    try {
      final listAccounts = await _accountDatasource.getAccountInfo();
      double sum = 0;
      String balance = '';
      for (var element in listAccounts) {
        sum += element.saldo;
      }
      balance = (sum / 100).toStringAsFixed(2).replaceAll('.', ',');
      AccountsInfosEntity accountInfoModel =
          AccountsInfosEntity(accountsInfos: listAccounts, balance: balance);
      return accountInfoModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
