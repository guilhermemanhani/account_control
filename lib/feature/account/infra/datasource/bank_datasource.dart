import '../../../account/account.dart';

abstract class BankDatasource {
  Future<List<BankEntity>> getBank();
}
