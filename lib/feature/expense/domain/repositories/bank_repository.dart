import '../../domain/entities/entities.dart';

abstract class BankRepository {
  Future<List<BankEntity>> getBank();
}
