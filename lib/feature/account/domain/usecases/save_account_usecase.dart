import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

abstract class SaveAccountUsecase {
  Future<bool> call({required SaveAccountEntity saveAccountEntity});
}

class SaveAccountUsecaseImpl implements SaveAccountUsecase {
  final SaveAccountRepository _saveAccountRepository;

  SaveAccountUsecaseImpl({
    required SaveAccountRepository saveAccountRepository,
  }) : _saveAccountRepository = saveAccountRepository;

  @override
  Future<bool> call({required SaveAccountEntity saveAccountEntity}) async {
    return await _saveAccountRepository.saveAccount(
      saveAccountEntity: saveAccountEntity,
    );
  }
}
