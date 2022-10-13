import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class SaveBankRepositoryImpl implements SaveBankRepository {
  final SaveBankDatasource _saveBankDatasource;

  SaveBankRepositoryImpl({
    required SaveBankDatasource saveBankDatasource,
  }) : _saveBankDatasource = saveBankDatasource;

  @override
  Future<bool> saveBank({required BankEntity bank}) async {
    try {
      return await _saveBankDatasource.saveBank(bank: bank);
      // } on SaveLocalFailure {
      //   rethrow;
    } catch (error, stackTrace) {
      throw UnknownSaveAccountFailure(
          stackTrace: stackTrace, label: 'saveLocalRepositoryImpl-saveAccount');
    }
  }
}
