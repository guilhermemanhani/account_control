import '../../domain/entities/save_account_entity.dart';

abstract class SaveAccountDatasource {
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity});
}
