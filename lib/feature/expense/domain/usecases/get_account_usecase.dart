import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/domain/repositories/account_repository.dart';

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
    return await _accountRepository.getAccount();
  }
}
