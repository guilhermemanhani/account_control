import '../entities/entities.dart';

abstract class AccountInfoRepository {
  Future<AccountsInfosEntity> getAccountInfo();
}
