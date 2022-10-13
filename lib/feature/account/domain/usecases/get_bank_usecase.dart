import '../../../account/account.dart';

abstract class GetBankUsecase {
  Future<List<BankEntity>> call();
}

class GetBankUsecaseImpl implements GetBankUsecase {
  final BankRepository _bankRepository;

  GetBankUsecaseImpl({
    required BankRepository bankRepository,
  }) : _bankRepository = bankRepository;

  @override
  Future<List<BankEntity>> call() async {
    return await _bankRepository.getBank();
  }
}
