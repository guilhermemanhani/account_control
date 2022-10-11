import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class SaveAccountRepositoryImpl implements SaveAccountRepository {
  final SaveAccountDatasource _saveAccountDatasource;

  SaveAccountRepositoryImpl({
    required SaveAccountDatasource saveAccountDatasource,
  }) : _saveAccountDatasource = saveAccountDatasource;

  @override
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity}) {
    try {
      SaveAccountEntity accountEntity = SaveAccountEntity(
        conta: saveAccountEntity.conta,
        id: saveAccountEntity.id,
        idbanco: saveAccountEntity.idbanco,
        saldo: saveAccountEntity.saldo * 100,
      );
      return _saveAccountDatasource.saveAccount(
        saveAccountEntity: accountEntity,
      );
    } on SaveAccountFailure {
      rethrow;
    } catch (error, stackTrace) {
      throw UnknownSaveAccountFailure(
          stackTrace: stackTrace,
          label: 'saveAccountRepositoryImpl-saveAccount');
    }
  }
}
