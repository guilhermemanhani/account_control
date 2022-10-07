import 'package:account_control/feature/account/domain/failures/save_account_failure.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../../infra/datasource/datasource.dart';

class SaveAccountRepositoryImpl implements SaveAccountRepository {
  final SaveAccountDatasource _saveAccountDatasource;

  SaveAccountRepositoryImpl({
    required SaveAccountDatasource saveAccountDatasource,
  }) : _saveAccountDatasource = saveAccountDatasource;

  @override
  Future<bool> saveAccount({required SaveAccountEntity saveAccountEntity}) {
    try {
      return _saveAccountDatasource.saveAccount(
        saveAccountEntity: saveAccountEntity,
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
