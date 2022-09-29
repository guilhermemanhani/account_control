import 'package:account_control/feature/home/domain/entities/account_info_entity.dart';
import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';
import 'package:account_control/feature/home/infra/datasource/account_info_datasource.dart';

class AccountInfoRepositoryImpl implements AccountInfoRepository {
  final AccountInfoDatasource _accountDatasource;

  AccountInfoRepositoryImpl({
    required AccountInfoDatasource accountDatasource,
  }) : _accountDatasource = accountDatasource;
  @override
  Future<List<AccountInfoEntity>> getAccountInfo() {
    // TODO: implement getAccountInfo
    throw UnimplementedError();
  }
}
