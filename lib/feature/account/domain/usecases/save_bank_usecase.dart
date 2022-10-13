import '../../../account/account.dart';

abstract class SaveBankUsecase {
  Future<bool> call({required BankEntity bank});
}

class SaveBankUsecaseImpl implements SaveBankUsecase {
  final SaveBankRepository _bankRepository;

  SaveBankUsecaseImpl({
    required SaveBankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<bool> call({required BankEntity bank}) async {
    return await _bankRepository.saveBank(bank: bank);
  }
}
