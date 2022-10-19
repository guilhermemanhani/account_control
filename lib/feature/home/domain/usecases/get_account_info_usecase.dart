import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class GetAccountInfoUsecase {
  Future<AccountsInfosEntity> call();
}

class GetAccountInfoUsecaseImpl implements GetAccountInfoUsecase {
  final AccountInfoRepository _accountInfoRepositoryRepository;

  GetAccountInfoUsecaseImpl({
    required AccountInfoRepository accountInfoRepositoryRepository,
  }) : _accountInfoRepositoryRepository = accountInfoRepositoryRepository;

  @override
  Future<AccountsInfosEntity> call() async {
    return await _accountInfoRepositoryRepository.getAccountInfo();
  }
}
