import 'package:account_control/feature/home/domain/entities/entities.dart';
import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';

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
