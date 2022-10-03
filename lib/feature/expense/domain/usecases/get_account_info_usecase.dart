import 'package:account_control/feature/home/domain/entities/account_info_entity.dart';
import 'package:account_control/feature/home/domain/repositories/account_info_repository.dart';

abstract class GetAccountInfoUsecase {
  Future<List<AccountInfoEntity>> call();
}

class GetAccountInfoUsecaseImpl implements GetAccountInfoUsecase {
  final AccountInfoRepository _accountInfoRepositoryRepository;

  GetAccountInfoUsecaseImpl({
    required AccountInfoRepository accountInfoRepositoryRepository,
  }) : _accountInfoRepositoryRepository = accountInfoRepositoryRepository;

  @override
  Future<List<AccountInfoEntity>> call() async {
    return await _accountInfoRepositoryRepository.getAccountInfo();
  }
}
