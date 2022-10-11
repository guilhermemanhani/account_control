import '../../domain/entities/entities.dart';

abstract class SaveAccountDatasource {
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity});
}
