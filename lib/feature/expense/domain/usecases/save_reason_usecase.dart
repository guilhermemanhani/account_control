import '../entities/entities.dart';
import '../repositories/repositories.dart';

abstract class SaveReasonUsecase {
  Future<bool> call({required ReasonEntity reason});
}

class SaveReasonUsecaseImpl implements SaveReasonUsecase {
  final SaveReasonRepository _reasonRepository;

  SaveReasonUsecaseImpl({
    required SaveReasonRepository reasonRepository,
  }) : _reasonRepository = reasonRepository;

  @override
  Future<bool> call({required ReasonEntity reason}) async {
    return await _reasonRepository.saveReason(reason: reason);
  }
}
