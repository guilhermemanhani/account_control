import 'package:account_control/feature/expense/domain/entities/bank_entity.dart';

abstract class BankRepository {
  Future<List<BankEntity>> getBank();
}
