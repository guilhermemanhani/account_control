import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class SaveLocalUsecase {
  Future<bool> call({required LocalEntity local});
}

class SaveLocalUsecaseImpl implements SaveLocalUsecase {
  final SaveLocalRepository _localRepository;

  SaveLocalUsecaseImpl({
    required SaveLocalRepository localRepository,
  }) : _localRepository = localRepository;

  @override
  Future<bool> call({required LocalEntity local}) async {
    return await _localRepository.saveLocal(local: local);
  }
}
