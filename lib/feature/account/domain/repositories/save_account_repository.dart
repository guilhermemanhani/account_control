import '../../domain/entities/save_account_entity.dart';

abstract class SaveAccountRepository {
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity});
}
