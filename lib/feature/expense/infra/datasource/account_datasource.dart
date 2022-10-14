import '../../domain/entities/entities.dart';

abstract class AccountDatasource {
  Future<List<AccountEntity>> getAccounts();
  Future<AccountEntity> getAccount({required int id});
}
