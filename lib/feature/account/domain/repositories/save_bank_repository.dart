import '../../domain/entities/entities.dart';

abstract class SaveBankRepository {
  Future<bool> saveBank({required BankEntity bank});
}
