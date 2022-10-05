import '../../domain/entities/entities.dart';

abstract class AccountDatasource {
  Future<List<AccountEntity>> getAccount();
}
