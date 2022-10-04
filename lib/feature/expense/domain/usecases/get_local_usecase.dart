import 'package:account_control/feature/expense/domain/entities/local_entity.dart';
import 'package:account_control/feature/expense/domain/repositories/local_repository.dart';

abstract class GetLocalUsecase {
  Future<List<LocalEntity>> call();
}

class GetLocalUsecaseImpl implements GetLocalUsecase {
  final LocalRepository _localRepository;

  GetLocalUsecaseImpl({
    required LocalRepository localRepository,
  }) : _localRepository = localRepository;

  @override
  Future<List<LocalEntity>> call() async {
    return await _localRepository.getLocal();
  }
}
