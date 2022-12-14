import '../entities/entities.dart';
import '../repositories/repositories.dart';

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
