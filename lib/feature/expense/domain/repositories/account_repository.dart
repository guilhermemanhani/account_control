import '../../domain/entities/entities.dart';

abstract class AccountRepository {
  Future<List<AccountEntity>> getAccount();
}
