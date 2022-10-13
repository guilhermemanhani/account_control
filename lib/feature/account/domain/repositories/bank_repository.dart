import '../../../account/account.dart';

abstract class BankRepository {
  Future<List<BankEntity>> getBank();
}
