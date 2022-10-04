import 'package:account_control/feature/expense/domain/entities/reason_entity.dart';
import 'package:account_control/feature/expense/domain/repositories/reason_repository.dart';

abstract class GetReasonUsecase {
  Future<List<ReasonEntity>> call();
}

class GetReasonUsecaseImpl implements GetReasonUsecase {
  final ReasonRepository _reasonRepository;

  GetReasonUsecaseImpl({
    required ReasonRepository reasonRepository,
  }) : _reasonRepository = reasonRepository;

  @override
  Future<List<ReasonEntity>> call() async {
    return await _reasonRepository.getReason();
  }
}
