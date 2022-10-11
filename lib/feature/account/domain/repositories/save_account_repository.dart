import '../../domain/entities/entities.dart';

abstract class SaveAccountRepository {
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity});
}
