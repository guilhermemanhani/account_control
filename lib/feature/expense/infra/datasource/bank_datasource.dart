import '../../domain/entities/entities.dart';

abstract class BankDatasource {
  Future<List<BankEntity>> getBank();
}
