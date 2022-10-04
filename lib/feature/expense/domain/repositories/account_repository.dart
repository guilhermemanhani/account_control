import 'package:account_control/feature/expense/domain/entities/account_entity.dart';

abstract class AccountRepository {
  Future<List<AccountEntity>> getAccount();
}
