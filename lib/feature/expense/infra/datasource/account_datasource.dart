import 'package:account_control/feature/expense/domain/entities/account_entity.dart';

abstract class AccountDatasource {
  Future<List<AccountEntity>> getAccount();
}
