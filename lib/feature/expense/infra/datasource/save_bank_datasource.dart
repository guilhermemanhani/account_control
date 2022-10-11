import '../../domain/entities/entities.dart';

abstract class SaveBankDatasource {
  Future<bool> saveBank({required BankEntity bank});
}
