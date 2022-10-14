import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class GetAccountUsecase {
  Future<List<AccountEntity>> call();
}

class GetAccountUsecaseImpl implements GetAccountUsecase {
  final AccountRepository _accountRepository;

  GetAccountUsecaseImpl({
    required AccountRepository accountRepository,
  }) : _accountRepository = accountRepository;

  @override
  Future<List<AccountEntity>> call() async {
    return await _accountRepository.getAccounts();
  }
}
